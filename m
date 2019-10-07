Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFB2CDA60
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2019 04:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfJGCBy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Oct 2019 22:01:54 -0400
Received: from onstation.org ([52.200.56.107]:33194 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfJGCBx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 6 Oct 2019 22:01:53 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 78E843E993;
        Mon,  7 Oct 2019 02:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1570413712;
        bh=siGWMgbrgb+20s6v5IDlxItW2optKHnyECSIZMUdXig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvTNK9Yz7kQHuKGejnj4blW9gNA47X4z3/NOu47ocWrvNGYUaCQH1S1ESdEsIcIts
         QbXVe2EqqsJK+wvDoZ12k9X7ba9rHuE7p0gTW3dsidijC02JprpFBiKoM1KiVTeDGv
         QqWzc8pdlgKIkhaRFmj5fjWSZObYleCU7m9vnyfk=
Date:   Sun, 6 Oct 2019 22:01:52 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/5] soc: qcom: smd-rpm: Create RPM interconnect proxy
 child device
Message-ID: <20191007020152.GA16902@onstation.org>
References: <20190613151323.10850-1-georgi.djakov@linaro.org>
 <20190613151323.10850-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613151323.10850-3-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 13, 2019 at 06:13:20PM +0300, Georgi Djakov wrote:
> Register a platform device to handle the communication of bus bandwidth
> requests with the remote processor. The interconnect proxy device is part
> of this remote processor (RPM) hardware. Let's create a icc-smd-rpm proxy
> child device to represent the bus throughput functionality that is provided
> by the RPM.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Brian Masney <masneyb@onstation.org>
Tested-by: Brian Masney <masneyb@onstation.org> # msm8974

I think this patch may have fell through the cracks since I don't see
it in linux-next. The qcs404 patches in this series were merged.

Brian

> ---
> 
> v4:
> - Return error if platform_device_register_data() fails
> - Remove platform_set_drvdata() on the child device.
> 
> v3:
> - New patch.
> 
>  drivers/soc/qcom/smd-rpm.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> index fa9dd12b5e39..34cdd638a6c1 100644
> --- a/drivers/soc/qcom/smd-rpm.c
> +++ b/drivers/soc/qcom/smd-rpm.c
> @@ -19,12 +19,14 @@
>  /**
>   * struct qcom_smd_rpm - state of the rpm device driver
>   * @rpm_channel:	reference to the smd channel
> + * @icc:		interconnect proxy device
>   * @ack:		completion for acks
>   * @lock:		mutual exclusion around the send/complete pair
>   * @ack_status:		result of the rpm request
>   */
>  struct qcom_smd_rpm {
>  	struct rpmsg_endpoint *rpm_channel;
> +	struct platform_device *icc;
>  	struct device *dev;
>  
>  	struct completion ack;
> @@ -193,6 +195,7 @@ static int qcom_smd_rpm_callback(struct rpmsg_device *rpdev,
>  static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
>  {
>  	struct qcom_smd_rpm *rpm;
> +	int ret;
>  
>  	rpm = devm_kzalloc(&rpdev->dev, sizeof(*rpm), GFP_KERNEL);
>  	if (!rpm)
> @@ -205,11 +208,23 @@ static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
>  	rpm->rpm_channel = rpdev->ept;
>  	dev_set_drvdata(&rpdev->dev, rpm);
>  
> -	return of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
> +	rpm->icc = platform_device_register_data(&rpdev->dev, "icc_smd_rpm", -1,
> +						 NULL, 0);
> +	if (IS_ERR(rpm->icc))
> +		return PTR_ERR(rpm->icc);
> +
> +	ret = of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
> +	if (ret)
> +		platform_device_unregister(rpm->icc);
> +
> +	return ret;
>  }
>  
>  static void qcom_smd_rpm_remove(struct rpmsg_device *rpdev)
>  {
> +	struct qcom_smd_rpm *rpm = dev_get_drvdata(&rpdev->dev);
> +
> +	platform_device_unregister(rpm->icc);
>  	of_platform_depopulate(&rpdev->dev);
>  }
>  
