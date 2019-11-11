Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52833F6E40
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 06:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfKKFtp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 00:49:45 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:13898 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfKKFtp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 00:49:45 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191111054941epoutp03493355a9980162977f921412d4454066~WBbH06ozI1363213632epoutp03B
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2019 05:49:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191111054941epoutp03493355a9980162977f921412d4454066~WBbH06ozI1363213632epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573451381;
        bh=olReB5/sYyr6noqS7XjlPXjfuQaRIcMYAnEV2FSvs6Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ymugn/s5U+QuOL7HUN2/ZZo3qBmqL9lTKZMxxMj/gxMH3i1ODaS3PTKShubs4JrH1
         y+lujfv4d1oZx60U6y6cL363F1GTu4YBgLzxO02Cmug/DUJCpPGeXFCPufUMyDIh3P
         o2r3+fXjHrePpWTfQ/1S3F3hYSGL+ocy1cG4fjSE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191111054940epcas1p4f0602a2ab46daa5bb129e41bca93fd4a~WBbHLRA2H3052130521epcas1p4b;
        Mon, 11 Nov 2019 05:49:40 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47BKhL4H2szMqYkq; Mon, 11 Nov
        2019 05:49:38 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.27.04068.276F8CD5; Mon, 11 Nov 2019 14:49:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191111054938epcas1p37100eab66b763e82859bcb1a720bfa2e~WBbEb8VtH0597105971epcas1p3R;
        Mon, 11 Nov 2019 05:49:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191111054938epsmtrp276d1e4f705606c47d544c69e42d9ce78~WBbEbFNmJ2689626896epsmtrp2j;
        Mon, 11 Nov 2019 05:49:38 +0000 (GMT)
X-AuditID: b6c32a39-3b9219c000000fe4-38-5dc8f67297cc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.80.25663.176F8CD5; Mon, 11 Nov 2019 14:49:37 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191111054937epsmtip159dad636d80d77725e70cfcb43e636be~WBbEJb_gT3130731307epsmtip1g;
        Mon, 11 Nov 2019 05:49:37 +0000 (GMT)
Subject: Re: [PATCH v10 01/11] PM / devfreq: Fix devfreq_notifier_call
 returning errno
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3e31fce5-97ec-5f69-d352-d45a7cf0eb75@samsung.com>
Date:   Mon, 11 Nov 2019 14:55:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b13007563e6c1e29e2d9b31c9881693fc2bf167a.1572556786.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJsWRmVeSWpSXmKPExsWy7bCmvm7RtxOxBv8nK1ocOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht1hx9yOrxabH11gtun6tZLb43HuE0eLzhseMFrcbV7BZ
        rD53kM3izOlLQNlDf9ksNn71cBDweH+jld1jdsNFFo8Fm0o9Nq3qZPO4c20Pm8fmJfUeG9/t
        YPI4+G4Pk8eWq+0sHn1bVjF6fN4kF8AdlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhr
        aGlhrqSQl5ibaqvk4hOg65aZA/SOkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA
        skCvODG3uDQvXS85P9fK0MDAyBSoMCE7Y/maX8wFzwUqNp3+zdrAeIy3i5GTQ0LAROLI+ycs
        ILaQwA5GiU/v7LoYuYDsT4wSV67sZYZIfGOUODpdFaah//oSFoiivYwSE78sgip6zyjxeXo2
        iC0sECHxdscNZpAiEYF1jBJ/DncxgTjMAg+YJSZN/c0IUsUmoCWx/8UNNhCbX0BR4uqPx2Bx
        XgE7iVUrv4JNZRFQlTh2dTdrFyMHhyjQ1NNfEyFKBCVOzoQ4m1MgTuLL9+3sIDazgLjErSfz
        mSBseYntb+eAHSEhcI9dYlX3ORaIF1wkutveMkPYwhKvjm9hh7ClJD6/28sGYVdLrDx5hA2i
        uYNRYsv+C6wQCWOJ/UsnM4EcxCygKbF+lz5EWFFi5++5jBCL+STefe0Bu1lCgFeio00IokRZ
        4vKDu0wQtqTE4vZOtgmMSrOQvDMLyQuzkLwwC2HZAkaWVYxiqQXFuempxYYFpsiRvYkRnNK1
        LHcwHjvnc4hRgINRiYc3QP9ErBBrYllxZe4hRgkOZiUR3h0VQCHelMTKqtSi/Pii0pzU4kOM
        psDAnsgsJZqcD8w3eSXxhqZGxsbGFiaGZqaGhkrivI7Ll8YKCaQnlqRmp6YWpBbB9DFxcEo1
        MFoFRzwp3OWWsVz84PM1p7zmaJ+drx12PpZ7ngr/Hxm1htYvEzzbWcKv9yzeFa+nY6+659ff
        bM7om+dFt3NvihatmLrI85ngjx/Vy5+npendFGdpye6PV9m27cyjJ983NOiJB7nd2swwa3al
        WHZObr+wWnLad+e9L24tLTz4w273BE82xxLPNCWW4oxEQy3mouJEADHrggD/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02RXUhTYRjHfXfOzs5Wo7f59WqotahgmWlEvZCKoBcHg+gDxEKzYx5Ucm7t
        6FKJNKEPLaurSkvzYpquIF1+5RbDqWvqUhyoK/MiNQxqVujMLCGPK/Du9/w/nufioQnFOzKU
        zs0v4HT5bJ6SkpEdvcrwfReXHOnR1lex2GZvl2Dv0CDAja5+gB+8NlF4ZKRFgt+Wf5Xgpqkf
        YmyaGRfjypVmAi9U9QG80DID8OTVJgo/G+6hsHPItebaVinc6mUSIPPNfU3CPCobJZl6UyFj
        MlZQzIdxC8W8NJQyrfNdIqZn3iJi2sZukMydNiNgFkzhxzedkcVmcXm5ek63P/6cLOfp8xVC
        OweLTEO/xWXALq8EUhrBg+juhIGsBDJaAc0A3bTPUz4jBN0f7ScqAb3G/qi3l/dlPABV13WL
        hIw/TEWeLjchGAGwBaDm9lWRMBBwmkAdNu/6JgWcBqj7zXaBKahC1s/udX0L3IHGlmeAwHIY
        j4zNXkJgEu5C9jGzWODAtQtzne5/ma1ooHqWFFgKz6LFn50SgQm4B/2pcxE+DkbvZ5+IfByB
        Oj2PiXvAv2ZDvWZDpWZDpWZDpR6QRhDCaXl1tpqP0R7I5y5F8ayaL8zPjjqvUZvA+sNVqi7g
        cGTYAKSBcrN8OdKRrhCzer5YbQOIJpQB8q6iNUmexRaXcDpNhq4wj+NtYBtNKoPlERr7aQXM
        Zgu4Cxyn5XT/XREtDS0DJ8uDUhuHpR9Vhl9HXE5NStWVxczdft2TSwMN8SOs4QQ83OC8nlTS
        hwc/7awz1H5n0vTMQ2er90tg1S2qIm5AYz4l8Uwll+Kizst+tUfZPkdimnUhOSgxLjrsWKpy
        NWciM46O7AhrfGE2ogQbPJRCsKEVeqfFaku6jSx7lSSfw8aoCB3P/gXCmGeX7AIAAA==
X-CMS-MailID: 20191111054938epcas1p37100eab66b763e82859bcb1a720bfa2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191031213438epcas1p3c8f3e43372631fd66f28bbaff6925001
References: <cover.1572556786.git.leonard.crestez@nxp.com>
        <CGME20191031213438epcas1p3c8f3e43372631fd66f28bbaff6925001@epcas1p3.samsung.com>
        <b13007563e6c1e29e2d9b31c9881693fc2bf167a.1572556786.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/1/19 6:34 AM, Leonard Crestez wrote:
> Notifier callbacks shouldn't return negative errno but one of the
> NOTIFY_OK/DONE/BAD values.
> 
> The OPP core will ignore return values from notifiers but returning a
> value that matches NOTIFY_STOP_MASK will stop the notification chain.
> 
> Fix by always returning NOTIFY_OK.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 323d43315d1e..b65faa1a2baa 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -548,30 +548,32 @@ EXPORT_SYMBOL(devfreq_interval_update);
>   */
>  static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  				 void *devp)
>  {
>  	struct devfreq *devfreq = container_of(nb, struct devfreq, nb);
> -	int ret;
> +	int err = -EINVAL;
>  
>  	mutex_lock(&devfreq->lock);
>  
>  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> -	if (!devfreq->scaling_min_freq) {
> -		mutex_unlock(&devfreq->lock);
> -		return -EINVAL;
> -	}
> +	if (!devfreq->scaling_min_freq)
> +		goto out;
>  
>  	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> -	if (!devfreq->scaling_max_freq) {
> -		mutex_unlock(&devfreq->lock);
> -		return -EINVAL;
> -	}
> +	if (!devfreq->scaling_max_freq)
> +		goto out;
> +
> +	err = update_devfreq(devfreq);
>  
> -	ret = update_devfreq(devfreq);
> +out:
>  	mutex_unlock(&devfreq->lock);
> +	if (err)
> +		dev_err(devfreq->dev.parent,
> +			"failed to update frequency from OPP notifier (%d)\n",
> +			err);
>  
> -	return ret;
> +	return NOTIFY_OK;
>  }
>  
>  /**
>   * devfreq_dev_release() - Callback for struct device to release the device.
>   * @dev:	the devfreq device
> 

Applied it because it doesn't depend on the pm_qos feature.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
