Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0295010C9BA
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 14:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfK1NnG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 08:43:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41579 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfK1NnG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 08:43:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id m4so28540509ljj.8;
        Thu, 28 Nov 2019 05:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k++zKOWR7+l/xQIAkNb0fLZi0BFwwtjyoFUG5S/EzTQ=;
        b=Anr74Gy0lFS1cEnVC+5++VOKZzfAF1xunFXGF95LQcwnt8mjR1BoAAQNUB6CtNen70
         6ZEqFqYBdzMzE2m2zaF9+IQMa0gFRJ1L3Fa2HhpR0wFLLWXE7pa6c8kfbJmLw7a6HkuE
         5tQNHkCRUhgoAYP/GiJcgqNsff1sdKlkqNA9+o0lDdmhyPdPJL5bX0U+Ldd+OHmmpR0v
         4ttPOO5gpeJN3hQwmR9GJMcQgWSbQqzrv/PlvjOWD6+E47+VCjGO8UhzvYOulGUnM4yw
         AoP1S4wj8d7naGJLjKwwOiRGHWnaPtsATtii/Dx2seE22S71XRFPsx8F3VieuXEIEyLr
         Di1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k++zKOWR7+l/xQIAkNb0fLZi0BFwwtjyoFUG5S/EzTQ=;
        b=Dpf3jrds5mY3g2l6KgnMDaD30VKp4KxRWvgxfcM87opNRMmXKUjo3D3aCI+9NACq0g
         0Xl3qai68Ya26UihzGDys98QMJWNNUwg0YMy7Md9deiurdkJCiaWNopKqE3bb8G+r7NK
         0D9vV0p48Nxs1GlZMw5NTm5uduaL4H09iLEihP7H6SqAIGJJMJt3D/kSskpOFgYo8hAm
         Aqi+sWqfbmVMeO/GP0fbFehpn4dFn+cp4yEU0/4d9mkgw2epVbVl9s7N43k3E8WsghOY
         coV9xHQVAsKPvdslnD2Yc54B7iWExligT4tgTjzXuScSO9HN+sEvyOhmXvG/cfK9KH0O
         i/+A==
X-Gm-Message-State: APjAAAUiY9rHx/iRT1GE5PTbIsRKTsWAlAx0yhDI+Kb6PTzm8w5lOf5c
        W0sT3Q7xZU0sPzvhO71TmWMYuxAX
X-Google-Smtp-Source: APXvYqzcQE+bVA3nOvw6x4i6uhErx84iEbgBf0inm07P7/UyMpc1ogVQJ9E5vgkROc/O1sOpORHvVg==
X-Received: by 2002:a2e:81c1:: with SMTP id s1mr33861504ljg.83.1574948581976;
        Thu, 28 Nov 2019 05:43:01 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 207sm10026632ljj.72.2019.11.28.05.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 05:43:01 -0800 (PST)
Subject: Re: [PATCH 5/5] interconnect: qcom: Use the new common helper for
 node removal
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20191128133435.25667-1-georgi.djakov@linaro.org>
 <20191128133435.25667-5-georgi.djakov@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5686a003-d72f-7a20-4851-9ebb3d2e9b20@gmail.com>
Date:   Thu, 28 Nov 2019 16:43:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191128133435.25667-5-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

28.11.2019 16:34, Georgi Djakov пишет:
> There is a new helper function for removing all nodes. Let's use it instead
> of duplicating the code.
> 
> In addition to the above, instead of duplicating the code, simplify the
> probe function error path by calling driver removal function directly.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/qcom/msm8974.c | 40 ++++++++++-------------------
>  drivers/interconnect/qcom/qcs404.c  | 31 ++++++++--------------
>  drivers/interconnect/qcom/sdm845.c  | 29 +++++++--------------
>  3 files changed, 33 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
> index 0a1a8ba6afa7..8823dce811c3 100644
> --- a/drivers/interconnect/qcom/msm8974.c
> +++ b/drivers/interconnect/qcom/msm8974.c
> @@ -644,6 +644,15 @@ static int msm8974_icc_set(struct icc_node *src, struct icc_node *dst)
>  	return 0;
>  }
>  
> +static int msm8974_icc_remove(struct platform_device *pdev)
> +{
> +	struct msm8974_icc_provider *qp = platform_get_drvdata(pdev);
> +
> +	icc_nodes_remove(&qp->provider);
> +	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> +	return icc_provider_del(&qp->provider);
> +}
> +
>  static int msm8974_icc_probe(struct platform_device *pdev)
>  {
>  	const struct msm8974_icc_desc *desc;
> @@ -701,7 +710,8 @@ static int msm8974_icc_probe(struct platform_device *pdev)
>  	ret = icc_provider_add(provider);
>  	if (ret) {
>  		dev_err(dev, "error adding interconnect provider: %d\n", ret);
> -		goto err_disable_clks;
> +		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> +		return ret;
>  	}
>  
>  	for (i = 0; i < num_nodes; i++) {
> @@ -710,7 +720,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
>  		node = icc_node_create(qnodes[i]->id);
>  		if (IS_ERR(node)) {
>  			ret = PTR_ERR(node);
> -			goto err_del_icc;
> +			goto err;
>  		}
>  
>  		node->name = qnodes[i]->name;
> @@ -731,34 +741,12 @@ static int msm8974_icc_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -err_del_icc:
> -	list_for_each_entry_safe(node, &provider->nodes, node_list) {
> -		icc_node_del(node);
> -		icc_node_destroy(node->id);
> -	}
> -	icc_provider_del(provider);
> -
> -err_disable_clks:
> -	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> +err:
> +	msm8974_icc_remove(pdev);
>  
>  	return ret;
>  }
>  
> -static int msm8974_icc_remove(struct platform_device *pdev)
> -{
> -	struct msm8974_icc_provider *qp = platform_get_drvdata(pdev);
> -	struct icc_provider *provider = &qp->provider;
> -	struct icc_node *n;
> -
> -	list_for_each_entry_safe(n, &provider->nodes, node_list) {
> -		icc_node_del(n);
> -		icc_node_destroy(n->id);
> -	}
> -	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> -
> -	return icc_provider_del(provider);
> -}
> -
>  static const struct of_device_id msm8974_noc_of_match[] = {
>  	{ .compatible = "qcom,msm8974-bimc", .data = &msm8974_bimc},
>  	{ .compatible = "qcom,msm8974-cnoc", .data = &msm8974_cnoc},
> diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
> index d2b455021416..a4c6ba715f61 100644
> --- a/drivers/interconnect/qcom/qcs404.c
> +++ b/drivers/interconnect/qcom/qcs404.c
> @@ -406,6 +406,15 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  	return 0;
>  }
>  
> +static int qnoc_remove(struct platform_device *pdev)
> +{
> +	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
> +
> +	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> +	icc_nodes_remove(&qp->provider);
> +	return icc_provider_del(&qp->provider);
> +}
> +
>  static int qnoc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -494,31 +503,11 @@ static int qnoc_probe(struct platform_device *pdev)
>  
>  	return 0;
>  err:
> -	list_for_each_entry_safe(node, &provider->nodes, node_list) {
> -		icc_node_del(node);
> -		icc_node_destroy(node->id);
> -	}
> -	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> -	icc_provider_del(provider);
> +	qnoc_remove(pdev);
>  
>  	return ret;
>  }
>  
> -static int qnoc_remove(struct platform_device *pdev)
> -{
> -	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
> -	struct icc_provider *provider = &qp->provider;
> -	struct icc_node *n;
> -
> -	list_for_each_entry_safe(n, &provider->nodes, node_list) {
> -		icc_node_del(n);
> -		icc_node_destroy(n->id);
> -	}
> -	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> -
> -	return icc_provider_del(provider);
> -}
> -
>  static const struct of_device_id qcs404_noc_of_match[] = {
>  	{ .compatible = "qcom,qcs404-bimc", .data = &qcs404_bimc },
>  	{ .compatible = "qcom,qcs404-pcnoc", .data = &qcs404_pcnoc },
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> index 924c2d056d85..2b8f13e78471 100644
> --- a/drivers/interconnect/qcom/sdm845.c
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -768,6 +768,14 @@ static int cmp_vcd(const void *_l, const void *_r)
>  		return 1;
>  }
>  
> +static int qnoc_remove(struct platform_device *pdev)
> +{
> +	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
> +
> +	icc_nodes_remove(&qp->provider);
> +	return icc_provider_del(&qp->provider);
> +}
> +
>  static int qnoc_probe(struct platform_device *pdev)
>  {
>  	const struct qcom_icc_desc *desc;
> @@ -855,29 +863,10 @@ static int qnoc_probe(struct platform_device *pdev)
>  
>  	return ret;
>  err:
> -	list_for_each_entry(node, &provider->nodes, node_list) {
> -		icc_node_del(node);
> -		icc_node_destroy(node->id);
> -	}
> -
> -	icc_provider_del(provider);
> +	qnoc_remove(pdev);

This is wrong because platform_set_drvdata() is invoked at the end of
qnoc_probe(), thus platform_get_drvdata() of qnoc_remove() returns NULL
here.

>  	return ret;
>  }
>  
> -static int qnoc_remove(struct platform_device *pdev)
> -{
> -	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
> -	struct icc_provider *provider = &qp->provider;
> -	struct icc_node *n;
> -
> -	list_for_each_entry_safe(n, &provider->nodes, node_list) {
> -		icc_node_del(n);
> -		icc_node_destroy(n->id);
> -	}
> -
> -	return icc_provider_del(provider);
> -}
> -
>  static const struct of_device_id qnoc_of_match[] = {
>  	{ .compatible = "qcom,sdm845-rsc-hlos", .data = &sdm845_rsc_hlos },
>  	{ },
> 

