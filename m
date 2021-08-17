Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158093EED2E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 15:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbhHQNRx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 09:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbhHQNRw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 09:17:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237E9C061764
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 06:17:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x10so22264780wrt.8
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+GkZlku1Bw2JCl4HvkcPQD//HnyGFQIsuXa7PcP9+u4=;
        b=zobAv814/jIA9hveR+EkNCwDf42MUiRgvR0jepBC7V2gciaCGjUZ3styiQZrII/VGa
         qx77TDd0skliye2OiYngq8oLgDQoXMCxlS5/59T8Cl/xOwXettAGn+YoSLCW+UGsJyZn
         TIkq0LD3BN/+Czb9ip5I2Deej+XiqaImJxB/Mx+i0psWXBSOW2sn4rxNZihvLV50PFoL
         v6d+WfCiza0TKEFKzFuyGmjgTBZnlACPbs1usIJdMlQTed2Fb7I2O6DEr0dnY3K3tc3O
         ajC4oiwU9PuEuQJ7tn2zGDR40m+g9fPfDRM76GWajlGvHy0lRWgeU8eE/p6cIr0UXOAc
         l4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+GkZlku1Bw2JCl4HvkcPQD//HnyGFQIsuXa7PcP9+u4=;
        b=oIiu1yEM2gMhf8ZexIF7OqZjppJvIWjOjhoS0XPE2W/vG1hRTqZfNiOMmq8mHpNRzT
         fngRG9XKbzPsCZaykULn87Umv2IwILwScxSUgXK/bVLqgoSoug75kH88BwGOutgPNj9S
         14TXfAEhQieF+7CnhGhGiWarCZrZcancVty8Z2DzJL0TAdI5tJZnoUhNB4YmWHBgRJ33
         H24cPJv/otbabnrj435lr5XgDaJtaXFC6G6r3veF209WrNDbTzUXZCVQqCJc78+ubPpb
         /ABPnu8EJ68MIdCi0YDFEn9U3+ul5S6wifTvaXEBWw2+7eLVYOu964Df8pWYg/F0HMHa
         PWLw==
X-Gm-Message-State: AOAM531WlZNtdfIQkXOE9DXKJihIUh8o7g2YoPPdcM5gPke1RwsDdfze
        B4Ma4KtVPBvwHzEuQ8+KYIgLrQ==
X-Google-Smtp-Source: ABdhPJwiEhB1GoU5iRLmZV1y4Ji/YZrd0AlU+/xLj1e9DFnO2wK155hd4GpX9VHaaZ/iIKuoh1oVjQ==
X-Received: by 2002:adf:bb85:: with SMTP id q5mr4002312wrg.186.1629206237558;
        Tue, 17 Aug 2021 06:17:17 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:52c4:e6e5:cc9e:e70a? ([2a01:e34:ed2f:f020:52c4:e6e5:cc9e:e70a])
        by smtp.googlemail.com with ESMTPSA id f2sm2464427wru.31.2021.08.17.06.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 06:17:17 -0700 (PDT)
Subject: Re: [Patch v5 1/6] firmware: qcom_scm: Introduce SCM calls to access
 LMh
To:     Thara Gopinath <thara.gopinath@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     steev@kali.org, tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210809191605.3742979-1-thara.gopinath@linaro.org>
 <20210809191605.3742979-2-thara.gopinath@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <19659756-4716-4c5b-949a-58d362dcee22@linaro.org>
Date:   Tue, 17 Aug 2021 15:17:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809191605.3742979-2-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/08/2021 21:15, Thara Gopinath wrote:
> Introduce SCM calls to access/configure limits management hardware(LMH).
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Hi Bjorn, Andy,

do you mind if I pick this patch along with patch 2/6 ?

Thanks

  -- Daniel

> ---
> 
> v2->v3:
> 	Added freeing of payload_buf after the scm call in qcom_scm_lmh_dcvsh as per
> 	Matthias review comments.
> 
> v1->v2:
> 	Changed the input parameters in qcom_scm_lmh_dcvsh from payload_buf and
> 	payload_size to payload_fn, payload_reg, payload_val as per Bjorn's review
> 	comments.
> 
>  drivers/firmware/qcom_scm.c | 58 +++++++++++++++++++++++++++++++++++++
>  drivers/firmware/qcom_scm.h |  4 +++
>  include/linux/qcom_scm.h    | 14 +++++++++
>  3 files changed, 76 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 47ea2bd42b10..8a503753fe2a 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1147,6 +1147,64 @@ int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
>  }
>  EXPORT_SYMBOL(qcom_scm_qsmmu500_wait_safe_toggle);
>  
> +bool qcom_scm_lmh_dcvsh_available(void)
> +{
> +	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_LMH, QCOM_SCM_LMH_LIMIT_DCVSH);
> +}
> +EXPORT_SYMBOL(qcom_scm_lmh_dcvsh_available);
> +
> +int qcom_scm_lmh_profile_change(u32 profile_id)
> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_LMH,
> +		.cmd = QCOM_SCM_LMH_LIMIT_PROFILE_CHANGE,
> +		.arginfo = QCOM_SCM_ARGS(1, QCOM_SCM_VAL),
> +		.args[0] = profile_id,
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +	};
> +
> +	return qcom_scm_call(__scm->dev, &desc, NULL);
> +}
> +EXPORT_SYMBOL(qcom_scm_lmh_profile_change);
> +
> +int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
> +		       u64 limit_node, u32 node_id, u64 version)
> +{
> +	dma_addr_t payload_phys;
> +	u32 *payload_buf;
> +	int ret, payload_size = 5 * sizeof(u32);
> +
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_LMH,
> +		.cmd = QCOM_SCM_LMH_LIMIT_DCVSH,
> +		.arginfo = QCOM_SCM_ARGS(5, QCOM_SCM_RO, QCOM_SCM_VAL, QCOM_SCM_VAL,
> +					QCOM_SCM_VAL, QCOM_SCM_VAL),
> +		.args[1] = payload_size,
> +		.args[2] = limit_node,
> +		.args[3] = node_id,
> +		.args[4] = version,
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +	};
> +
> +	payload_buf = dma_alloc_coherent(__scm->dev, payload_size, &payload_phys, GFP_KERNEL);
> +	if (!payload_buf)
> +		return -ENOMEM;
> +
> +	payload_buf[0] = payload_fn;
> +	payload_buf[1] = 0;
> +	payload_buf[2] = payload_reg;
> +	payload_buf[3] = 1;
> +	payload_buf[4] = payload_val;
> +
> +	desc.args[0] = payload_phys;
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, NULL);
> +
> +	dma_free_coherent(__scm->dev, payload_size, payload_buf, payload_phys);
> +	return ret;
> +}
> +EXPORT_SYMBOL(qcom_scm_lmh_dcvsh);
> +
>  static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
>  {
>  	struct device_node *tcsr;
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index 632fe3142462..d92156ceb3ac 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -114,6 +114,10 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>  #define QCOM_SCM_SVC_HDCP		0x11
>  #define QCOM_SCM_HDCP_INVOKE		0x01
>  
> +#define QCOM_SCM_SVC_LMH			0x13
> +#define QCOM_SCM_LMH_LIMIT_PROFILE_CHANGE	0x01
> +#define QCOM_SCM_LMH_LIMIT_DCVSH		0x10
> +
>  #define QCOM_SCM_SVC_SMMU_PROGRAM		0x15
>  #define QCOM_SCM_SMMU_CONFIG_ERRATA1		0x03
>  #define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL	0x02
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index 0165824c5128..c0475d1c9885 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -109,6 +109,12 @@ extern int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
>  			     u32 *resp);
>  
>  extern int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
> +
> +extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
> +			      u64 limit_node, u32 node_id, u64 version);
> +extern int qcom_scm_lmh_profile_change(u32 profile_id);
> +extern bool qcom_scm_lmh_dcvsh_available(void);
> +
>  #else
>  
>  #include <linux/errno.h>
> @@ -170,5 +176,13 @@ static inline int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
>  
>  static inline int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
>  		{ return -ENODEV; }
> +
> +static inline int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
> +				     u64 limit_node, u32 node_id, u64 version)
> +		{ return -ENODEV; }
> +
> +static inline int qcom_scm_lmh_profile_change(u32 profile_id) { return -ENODEV; }
> +
> +static inline bool qcom_scm_lmh_dcvsh_available(void) { return -ENODEV; }
>  #endif
>  #endif
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
