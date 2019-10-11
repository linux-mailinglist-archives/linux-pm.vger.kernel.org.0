Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34A85D462B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 19:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfJKRFL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 13:05:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39572 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbfJKRFK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2019 13:05:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so6448696pff.6
        for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2019 10:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gH8CN6ifApnuUIuL6rRcDtc3+x1r+DnUSfP1BvRM+tU=;
        b=vi3AsMoBjn6t2StCoswScx6ITgLZ5Dgh/dkl10r9QPfaugvfwAw+Ks8xKYxym1++tD
         hvzb7DfDTq4FZZsRTjHm5lK07UpQR6ElOaQUNQh1vMdFAB9EJtAXJ5oRLCJ/gAyvebLp
         Y3GV0qJzrWd+xi/FPiAMnEJA2HE+WRUffyThCEm0vZX8MhhZCNZUfP4eUuHhX4RiUxMk
         UU42FAkEi+pbCIS8fIWqciAEA4L0F6B52OPRrzwBXuxRFdbC9yYQi87WND1dKMvBIaRH
         AhAc1Y3Z+JgaiNtoMDqv2EWxSrCg492dY9oa0cnWWSGU9eXqCgVgLip0sBwe9cQlgmfY
         tKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gH8CN6ifApnuUIuL6rRcDtc3+x1r+DnUSfP1BvRM+tU=;
        b=jCTnCe40G62dvdFAp6d+h36dDm5B5P0PAxNh/o0/ZbTcHD+eBfL/sgCV+fzUUVdKi1
         +MKSeBiep8z5+MbeYBwaprFrpoPlkToOBteLNFksr3VrhSI4eB9ulsSqVmRf9GfhfgsI
         RllJmHUeq6V+tcyJXarhk3aCNU9tXLQLcu93U2o6AzZEu97AWrPP7B9fkraThF/iK20z
         qQgeQnflaIHnD3IbLahwrVzT+r/0hXRHKS0y3fdd17ZvD8pA7/yMMnAObBQ3TxcErZUl
         ypSfeIETT5e/UR5bLIOtIlnU/eVYWvFDluaCiVOd9UOWz+tdgjwEMujv4HdWZqh5Qm8g
         jIHQ==
X-Gm-Message-State: APjAAAVb7JrwRKpqsUGGiqkQ6iMsep8o0lnqw50HrTezsgufji1u8Jjp
        bn/H6zj5K7uiF04HAgwJriGHVSk7Vq4=
X-Google-Smtp-Source: APXvYqxCYyvcatZuXiUrQiYQSR8LloHnPBCD0DgKGggGvjPKWDeBhtnUDZ0YgxWXDlWKV/vjoimEdg==
X-Received: by 2002:a62:2581:: with SMTP id l123mr17786124pfl.197.1570813509739;
        Fri, 11 Oct 2019 10:05:09 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 199sm10116069pfv.152.2019.10.11.10.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 10:05:08 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:05:06 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     georgi.djakov@linaro.org, robh+dt@kernel.org, agross@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jonathan@marek.ca
Subject: Re: [PATCH v2 2/2] interconnect: qcom: add msm8974 driver
Message-ID: <20191011170506.GD571@minitux>
References: <20191005114605.5279-1-masneyb@onstation.org>
 <20191005114605.5279-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005114605.5279-3-masneyb@onstation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat 05 Oct 04:46 PDT 2019, Brian Masney wrote:
> diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
[..]
> +static void msm8974_icc_rpm_smd_send(struct device *dev, int rsc_type,
> +				     char *name, int id, u64 val)
> +{
> +	int ret;
> +
> +	if (id == -1)
> +		return;
> +
> +	/*
> +	 * Setting the bandwidth requests for some nodes fails and this same
> +	 * behavior occurs on the downstream MSM 3.4 kernel sources based on
> +	 * errors like this in that kernel:
> +	 *
> +	 *   msm_rpm_get_error_from_ack(): RPM NACK Unsupported resource
> +	 *   AXI: msm_bus_rpm_req(): RPM: Ack failed
> +	 *   AXI: msm_bus_rpm_commit_arb(): RPM: Req fail: mas:32, bw:240000000
> +	 *
> +	 * Since there's no publicly available documentation for this hardware,
> +	 * and the bandwidth for some nodes in the path can be set properly,
> +	 * let's not return an error.
> +	 */

So presumably all that matters for paths including these endpoints is
the clk_set_rate() on the bus itself. But I prefer that we merge it like
you propose and then swing back to work out the details.

> +	ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE, rsc_type, id,
> +				    val);
> +	if (ret)
> +		dev_dbg(dev, "Cannot set bandwidth for node %s (%d): %d\n",
> +			name, id, ret);
> +}
> +

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
