Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D3DCDB6F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2019 07:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfJGF3B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Oct 2019 01:29:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45029 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfJGF3B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2019 01:29:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so7858094pfn.11
        for <linux-pm@vger.kernel.org>; Sun, 06 Oct 2019 22:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8CXK/TfIsFpbZLDTPIgvREp06YCnBiMnqmaYjisViyY=;
        b=LAR6H5ZasQ8iPevuWF+vXdOwHJGt5uk3xJbaFv6C3Wd9u8HmgtJ7Qg1L9LdY53wOkb
         VlAWraIS3WJAoWfzYnoOTrCajo64NTbKw29mvKtcijueTi461E0NhHneWYXchgRAwGPo
         OMLFjD8p8ob0dUXytONE0BJpczSF3nlVSXdXrh3BvIgv9AY1c+ZtfF4K81uinVuGJm9i
         mQEgpVY2dy5APQJBUNydRXtQtV7aEMZRBSm4hbPfzEv8nh+cXOUbiOHDsZXfpH+oefTi
         0P5coqYfZJRXraFDBNiwdwdnLyo4W/A77yzEzLD85hCoSy5o8VgzOEZabEEgo/QzXanB
         qnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8CXK/TfIsFpbZLDTPIgvREp06YCnBiMnqmaYjisViyY=;
        b=uONzHOEAzXBIyAZpSTjs+enfSsJ2MXx+/mx8LKFSPp6vww8+J/0T33Jp7HaATeAG2i
         m0xxahf2ucgFNP/E8LLZtdTiL7V/2TNCv6oY1eVRlEQRpV8iHVLLi92butbmiZyFF32V
         BATMx96DK2YHZPH4gDpP0fhrr5XDpR5kZXXFNZMcyWHNW6KbCy1cWL6UJlkIOWYxVVR9
         qTPJ2bWMQwZnX7gqDqFSosP4KA9N8XrmBEhVkV4ZuUn/Dk7EWwvOTKnxO9XodIdCOxt0
         SkCgnFSUnCr1DvwVw7V6bugZ5E0UGEfPRpZDx0mPkEo/0kYRwSAKM3766UaDcvhvprJp
         F/1w==
X-Gm-Message-State: APjAAAX9P0H79VO9QPuW3dUDRUOS4ocGT0sMHVzOFPvZYGncESby3Xzr
        8KpfNFLgYoRE6MhuhlUPen1ujg==
X-Google-Smtp-Source: APXvYqwARGPm8j9a3QW8CuObVYB93bhWW7qnb5wALsOagBKs4r23n5w4xw65KVbYM5DnmJnWEkGMBA==
X-Received: by 2002:a62:8683:: with SMTP id x125mr30083504pfd.108.1570426138723;
        Sun, 06 Oct 2019 22:28:58 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d20sm18058167pfq.88.2019.10.06.22.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 22:28:57 -0700 (PDT)
Date:   Sun, 6 Oct 2019 22:28:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, robh+dt@kernel.org,
        agross@kernel.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/5] soc: qcom: smd-rpm: Create RPM interconnect proxy
 child device
Message-ID: <20191007052855.GE2999@tuxbook-pro>
References: <20190613151323.10850-1-georgi.djakov@linaro.org>
 <20190613151323.10850-3-georgi.djakov@linaro.org>
 <20191007020152.GA16902@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007020152.GA16902@onstation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun 06 Oct 19:01 PDT 2019, Brian Masney wrote:

> On Thu, Jun 13, 2019 at 06:13:20PM +0300, Georgi Djakov wrote:
> > Register a platform device to handle the communication of bus bandwidth
> > requests with the remote processor. The interconnect proxy device is part
> > of this remote processor (RPM) hardware. Let's create a icc-smd-rpm proxy
> > child device to represent the bus throughput functionality that is provided
> > by the RPM.
> > 
> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> 
> Reviewed-by: Brian Masney <masneyb@onstation.org>
> Tested-by: Brian Masney <masneyb@onstation.org> # msm8974
> 
> I think this patch may have fell through the cracks since I don't see
> it in linux-next. The qcs404 patches in this series were merged.
> 

Yes, I was expecting Georgi to pick the entire series through his tree,
but see now that I didn't actually ask Georgi to do so. Sorry about
that.

I picked the this and the dts patch last week, so if it's not in
linux-next yet it should show up in the next one.

Thanks,
Bjorn

> Brian
> 
> > ---
> > 
> > v4:
> > - Return error if platform_device_register_data() fails
> > - Remove platform_set_drvdata() on the child device.
> > 
> > v3:
> > - New patch.
> > 
> >  drivers/soc/qcom/smd-rpm.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> > index fa9dd12b5e39..34cdd638a6c1 100644
> > --- a/drivers/soc/qcom/smd-rpm.c
> > +++ b/drivers/soc/qcom/smd-rpm.c
> > @@ -19,12 +19,14 @@
> >  /**
> >   * struct qcom_smd_rpm - state of the rpm device driver
> >   * @rpm_channel:	reference to the smd channel
> > + * @icc:		interconnect proxy device
> >   * @ack:		completion for acks
> >   * @lock:		mutual exclusion around the send/complete pair
> >   * @ack_status:		result of the rpm request
> >   */
> >  struct qcom_smd_rpm {
> >  	struct rpmsg_endpoint *rpm_channel;
> > +	struct platform_device *icc;
> >  	struct device *dev;
> >  
> >  	struct completion ack;
> > @@ -193,6 +195,7 @@ static int qcom_smd_rpm_callback(struct rpmsg_device *rpdev,
> >  static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
> >  {
> >  	struct qcom_smd_rpm *rpm;
> > +	int ret;
> >  
> >  	rpm = devm_kzalloc(&rpdev->dev, sizeof(*rpm), GFP_KERNEL);
> >  	if (!rpm)
> > @@ -205,11 +208,23 @@ static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
> >  	rpm->rpm_channel = rpdev->ept;
> >  	dev_set_drvdata(&rpdev->dev, rpm);
> >  
> > -	return of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
> > +	rpm->icc = platform_device_register_data(&rpdev->dev, "icc_smd_rpm", -1,
> > +						 NULL, 0);
> > +	if (IS_ERR(rpm->icc))
> > +		return PTR_ERR(rpm->icc);
> > +
> > +	ret = of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
> > +	if (ret)
> > +		platform_device_unregister(rpm->icc);
> > +
> > +	return ret;
> >  }
> >  
> >  static void qcom_smd_rpm_remove(struct rpmsg_device *rpdev)
> >  {
> > +	struct qcom_smd_rpm *rpm = dev_get_drvdata(&rpdev->dev);
> > +
> > +	platform_device_unregister(rpm->icc);
> >  	of_platform_depopulate(&rpdev->dev);
> >  }
> >  
