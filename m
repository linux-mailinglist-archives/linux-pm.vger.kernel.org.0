Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20DA59C61F
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2019 22:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfHYUl5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Aug 2019 16:41:57 -0400
Received: from onstation.org ([52.200.56.107]:46560 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbfHYUl5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 25 Aug 2019 16:41:57 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 479863E8B6;
        Sun, 25 Aug 2019 20:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1566765716;
        bh=WiaeHanYhnrEhirU8hAElFYgE0q/ORQXxd0mMPk5fwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTxYrxUAilLyyVOuEQdUrhtLJwOojFw0Urt+ZiT2giud8qo3MSKqVjLkWBeVpjA1C
         9TwwgdzEdiocS2icnbKVZ81fwRmlc2+h0nwyWPUv0QA1bRNG5mAUZpM0u2f0QIi2HF
         MRPpUPLdNpmQNTh/+kCKHAfLlrENwrde1EftnjRg=
Date:   Sun, 25 Aug 2019 16:41:55 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, agross@kernel.org, vkoul@kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 4/5] interconnect: qcom: Add QCS404 interconnect
 provider driver
Message-ID: <20190825204155.GA6879@onstation.org>
References: <20190723142339.27772-1-georgi.djakov@linaro.org>
 <20190723142339.27772-5-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723142339.27772-5-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi and Bjorn,

I'm finishing up a msm8974 interconnect driver and I used qcs404 as a
starting point. I have a question below.

On Tue, Jul 23, 2019 at 05:23:38PM +0300, Georgi Djakov wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add driver for the interconnect buses found in Qualcomm QCS404-based
> platforms. The topology consists of three NoCs that are controlled by
> a remote processor. This remote processor collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---

[snip]

> +enum {
> +       QCS404_MASTER_AMPSS_M0 = 1,

[snip]

> +#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
> +		     ...)						\
> +		static struct qcom_icc_node _name = {			\
> +		.name = #_name,						\
> +		.id = _id,						\
> +		.buswidth = _buswidth,					\
> +		.mas_rpm_id = _mas_rpm_id,				\
> +		.slv_rpm_id = _slv_rpm_id,				\
> +		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
> +		.links = { __VA_ARGS__ },				\
> +	}
> +
> +DEFINE_QNODE(mas_apps_proc, QCS404_MASTER_AMPSS_M0, 8, 0, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);

[snip]

> +static struct qcom_icc_node *qcs404_bimc_nodes[] = {
> +	[MASTER_AMPSS_M0] = &mas_apps_proc,

Should the id in DEFINE_QNODE() above be MASTER_AMPSS_M0 instead of
QCS404_MASTER_AMPSS_M0?

of_icc_xlate_onecell() looks up the id by the array index
MASTER_AMPSS_M0 (1), however qnoc_probe() passes the id that's
in struct qcom_icc_node to icc_node_create(), which is
QCS404_MASTER_AMPSS_M0 (0). They have different values and I'm unsure
why we can't just use the ids that are in qcom,qcs404.h and drop the
enum above.

Thanks,

Brian
