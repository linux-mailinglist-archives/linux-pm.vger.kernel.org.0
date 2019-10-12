Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9707DD4F36
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2019 13:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfJLLAq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Oct 2019 07:00:46 -0400
Received: from onstation.org ([52.200.56.107]:39942 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfJLLAq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 12 Oct 2019 07:00:46 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id E714D3E88D;
        Sat, 12 Oct 2019 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1570878045;
        bh=RKEyGbpvgWtwHv8UHOurWHkaxTHUsbMgak77d33UolU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=inOMyMioapH/dHJS9M7XNIdUmPxozcHiRqJ0lNduxURkpo+/iLn9/d7wAyigCB8ZI
         gYR/uXByl8UsSNdGbbksuAa0YEUvu8+K68Sr5h9tX/9bkb26U6W8NKI4FsAPBAU0Qk
         1ehSKMsZzLefA2hwou0q5RSjhw1g3vAVMtSR3YJM=
Date:   Sat, 12 Oct 2019 07:00:44 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     georgi.djakov@linaro.org, robh+dt@kernel.org, agross@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jonathan@marek.ca
Subject: Re: [PATCH v2 2/2] interconnect: qcom: add msm8974 driver
Message-ID: <20191012110044.GA19009@onstation.org>
References: <20191005114605.5279-1-masneyb@onstation.org>
 <20191005114605.5279-3-masneyb@onstation.org>
 <20191011170506.GD571@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011170506.GD571@minitux>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 11, 2019 at 10:05:06AM -0700, Bjorn Andersson wrote:
> On Sat 05 Oct 04:46 PDT 2019, Brian Masney wrote:
> > diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
> [..]
> > +static void msm8974_icc_rpm_smd_send(struct device *dev, int rsc_type,
> > +				     char *name, int id, u64 val)
> > +{
> > +	int ret;
> > +
> > +	if (id == -1)
> > +		return;
> > +
> > +	/*
> > +	 * Setting the bandwidth requests for some nodes fails and this same
> > +	 * behavior occurs on the downstream MSM 3.4 kernel sources based on
> > +	 * errors like this in that kernel:
> > +	 *
> > +	 *   msm_rpm_get_error_from_ack(): RPM NACK Unsupported resource
> > +	 *   AXI: msm_bus_rpm_req(): RPM: Ack failed
> > +	 *   AXI: msm_bus_rpm_commit_arb(): RPM: Req fail: mas:32, bw:240000000
> > +	 *
> > +	 * Since there's no publicly available documentation for this hardware,
> > +	 * and the bandwidth for some nodes in the path can be set properly,
> > +	 * let's not return an error.
> > +	 */
> 
> So presumably all that matters for paths including these endpoints is
> the clk_set_rate() on the bus itself.

That's the case for the GPU at the very least.

> But I prefer that we merge it like you propose and then swing back to
> work out the details.

Thanks,

Brian


> 
> > +	ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE, rsc_type, id,
> > +				    val);
> > +	if (ret)
> > +		dev_dbg(dev, "Cannot set bandwidth for node %s (%d): %d\n",
> > +			name, id, ret);
> > +}
> > +
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Regards,
> Bjorn
