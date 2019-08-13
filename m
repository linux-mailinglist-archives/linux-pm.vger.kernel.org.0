Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518BC8AD69
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 06:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfHMETp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 00:19:45 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:32593 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfHMETp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 00:19:45 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190813041941epoutp04ce6bc625a692ffb754d11fef36ea6ea1~6YI2g2GUU0177201772epoutp04k
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 04:19:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190813041941epoutp04ce6bc625a692ffb754d11fef36ea6ea1~6YI2g2GUU0177201772epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565669981;
        bh=07b7XUHda9WrEg1bmfF4iuDAMyHk6cA/OSKVvjSJkUU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Cl1zwdvFaSPWESLWkf2AzT6INysMEqH+8wYsSp8VyFYVKGeacAHO0+PgJdOehAS9E
         kXV0fsq0VoB7lAfkMlElab/UWra+y4vnx6YXLrDt9/OExRRg6Cqm6/yCorerSMod5s
         PABQMNJ41Y95Kg7muw2NhlbCWZu5+K2bxcM8A+II=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190813041941epcas1p4dbcf1ea21ec5a2c25e811f79955168b9~6YI10RW3S0854308543epcas1p43;
        Tue, 13 Aug 2019 04:19:41 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 466zy250zJzMqYkY; Tue, 13 Aug
        2019 04:19:38 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.53.04085.A5A325D5; Tue, 13 Aug 2019 13:19:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190813041937epcas1p3d80d80932d7240a07937737279e54f8c~6YIyv9mxc2852628526epcas1p3k;
        Tue, 13 Aug 2019 04:19:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190813041937epsmtrp1ccd83c1bfa681e68e24e7bfd0638b280~6YIyvCUTz2769827698epsmtrp1H;
        Tue, 13 Aug 2019 04:19:37 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-cd-5d523a5a19bb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.FA.03706.95A325D5; Tue, 13 Aug 2019 13:19:37 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190813041937epsmtip1c134ada5e8ba8ec2cdec25946e1444a3~6YIyZps391930419304epsmtip1q;
        Tue, 13 Aug 2019 04:19:37 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: passive: Use non-devm notifiers
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9ddb0fc0-5cdf-19a7-fac4-3c70002404b2@samsung.com>
Date:   Tue, 13 Aug 2019 13:23:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <38b77bb80d12aa788d4e234e399780a27dcd9e9f.1565282993.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJsWRmVeSWpSXmKPExsWy7bCmvm6UVVCswYIHyhaHjm1lt/h6+hSj
        xen971gsdj3Yxmbx8pCmxdzZkxgtmhevZ7M4f34Du8XZpjfsFrcaZCxW3P3IarHp8TVWi8+9
        RxgtbjeuYLOY+2Uqs0XXob9sDgIe72+0snssvnab1WPiWV2PBZtKPTat6mTzuHNtD5vH/rlr
        2D02L6n32PhuB5PHwXd7mDz6tqxi9Pi8SS6AJyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7U
        zMBQ19DSwlxJIS8xN9VWycUnQNctMwfoIyWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJq
        QUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsaUi2tYCnrEK67en8XSwNgp3MXIySEhYCKx
        YN5Xli5GLg4hgR2MEm83HmaFcD4xSvy8f5cZwvnGKNFy5CMrTMvtNW/ZIBJ7GSX6vv1mhHDe
        M0o8enAUyOHgEBZwkphzTAMkLiLQzCix9cRbJhCHWWAfi8SPWa/ARrEJaEnsf3GDDcTmF1CU
        uPrjMSOIzStgJ3H+2TGwGhYBVYnZd/eC2aICERKfHhxmhagRlDg58wkLiM0pECcx58ZssF5m
        AXGJW0/mM0HY8hLNW2eD/SAhcI9d4t6/n8wQP7hIXH5/hw3CFpZ4dXwLO4QtJfGyvw3KrpZY
        efIIG0RzB6PElv0XoAFgLLF/6WQmkDeZBTQl1u/ShwgrSuz8PZcRwuaVaNj4mx3iCD6Jd197
        WEHKQeIdbUIQJcoSlx/cZZrAqDwLyTuzkLwwC8kLsxCWLWBkWcUollpQnJueWmxYYIoc35sY
        weldy3IH47FzPocYBTgYlXh4KxICY4VYE8uKK3MPMUpwMCuJ8F4yCYoV4k1JrKxKLcqPLyrN
        SS0+xGgKDO2JzFKiyfnA3JNXEm9oamRsbGxhYmhmamioJM678IdFrJBAemJJanZqakFqEUwf
        EwenVANj5r1zEw8lJXbkn5LN35x4rlDw7IWlC35a3llye0X8cVGVwumzLBiXNtRcFjLqF36o
        Fnx+Uc7uyZI9OVc79sVfjjjl+HmZQo6id4Cgs43HDp/vIceS1suJPnBuY3mpcYMn74J7seOB
        m8c3yuZl7dqm67kprDgubWfW77d9pUWqmeERio06b6WVWIozEg21mIuKEwGTdpmiBQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCSnG6kVVCswZZlmhaHjm1lt/h6+hSj
        xen971gsdj3Yxmbx8pCmxdzZkxgtmhevZ7M4f34Du8XZpjfsFrcaZCxW3P3IarHp8TVWi8+9
        RxgtbjeuYLOY+2Uqs0XXob9sDgIe72+0snssvnab1WPiWV2PBZtKPTat6mTzuHNtD5vH/rlr
        2D02L6n32PhuB5PHwXd7mDz6tqxi9Pi8SS6AJ4rLJiU1J7MstUjfLoErY8rFNSwFPeIVV+/P
        Ymlg7BTuYuTkkBAwkbi95i1bFyMXh5DAbkaJS20/mCESkhLTLh4FsjmAbGGJw4eLIWreMkq8
        W/0TLC4s4CQx55gGSFxEoJVR4s7pH2CDmAUOsUi0dvZATd3IKLGm/ycLyFQ2AS2J/S9usIHY
        /AKKEld/PGYEsXkF7CTOPzvGCmKzCKhKzL67F8wWFYiQOLxjFlSNoMTJmU/A5nAKxEnMuTEb
        LM4soC7xZ94lZghbXOLWk/lMELa8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3P
        LTYsMMxLLdcrTswtLs1L10vOz93ECI5zLc0djJeXxB9iFOBgVOLhrUgIjBViTSwrrsw9xCjB
        wawkwnvJJChWiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6p
        BkbhQPZdTsv65zgqbJzbkaReUSEgMTmWu+fW25l3L5noqblq8vdJ37koOUNlperPH/1MP53j
        Zh870u4ndLiXQSBv6uPKjTtMNPjOnHq7XV1n1hYh9yKr8n+b/h+w/dU/P7T3jWysxME/1qzu
        HvYn+W52Tp0TfNnHVKkvZmrY4YsnNNY/ET505L0SS3FGoqEWc1FxIgAYDPHH7wIAAA==
X-CMS-MailID: 20190813041937epcas1p3d80d80932d7240a07937737279e54f8c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190808165416epcas5p24d8b4688357cd0985592e457c107d98b
References: <CGME20190808165416epcas5p24d8b4688357cd0985592e457c107d98b@epcas5p2.samsung.com>
        <38b77bb80d12aa788d4e234e399780a27dcd9e9f.1565282993.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 8. 9. 오전 1:54, Leonard Crestez wrote:
> The devfreq passive governor registers and unregisters devfreq
> transition notifiers on DEVFREQ_GOV_START/GOV_STOP using devm wrappers.
> 
> If devfreq itself is registered with devm then a warning is triggered on
> rmmod from devm_devfreq_unregister_notifier. Call stack looks like this:
> 
> 	devm_devfreq_unregister_notifier+0x30/0x40
> 	devfreq_passive_event_handler+0x4c/0x88
> 	devfreq_remove_device.part.8+0x6c/0x9c
> 	devm_devfreq_dev_release+0x18/0x20
> 	release_nodes+0x1b0/0x220
> 	devres_release_all+0x78/0x84
> 	device_release_driver_internal+0x100/0x1c0
> 	driver_detach+0x4c/0x90
> 	bus_remove_driver+0x7c/0xd0
> 	driver_unregister+0x2c/0x58
> 	platform_driver_unregister+0x10/0x18
> 	imx_devfreq_platdrv_exit+0x14/0xd40 [imx_devfreq]
> 
> This happens because devres_release_all will first remove all the nodes
> into a separate todo list so the nested devres_release from
> devm_devfreq_unregister_notifier won't find anything.
> 
> Fix the warning by calling the non-devm APIS for frequency notification.
> Using devm wrappers is not actually useful for a governor anyway: it
> relies on the devfreq core to correctly match the GOV_START/GOV_STOP
> notifications.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> ---
>  drivers/devfreq/governor_passive.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> The only current user of passive governor is exynos-bus; does rmmod work
> for you? Maybe I'm missing something.
> 
> It also seems that no attempt is made to increase the ref count of
> the passive "parent" so in theory devices can be removed while still
> referenced. However that would be a separate issue.
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 58308948b863..da485477065c 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -163,16 +163,16 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  	case DEVFREQ_GOV_START:
>  		if (!p_data->this)
>  			p_data->this = devfreq;
>  
>  		nb->notifier_call = devfreq_passive_notifier_call;
> -		ret = devm_devfreq_register_notifier(dev, parent, nb,
> +		ret = devfreq_register_notifier(parent, nb,
>  					DEVFREQ_TRANSITION_NOTIFIER);
>  		break;
>  	case DEVFREQ_GOV_STOP:
> -		devm_devfreq_unregister_notifier(dev, parent, nb,
> -					DEVFREQ_TRANSITION_NOTIFIER);
> +		WARN_ON(devfreq_unregister_notifier(parent, nb,
> +					DEVFREQ_TRANSITION_NOTIFIER));
>  		break;
>  	default:
>  		break;
>  	}
>  
> 

Looks good to me. But, you have to add the following fixes tag
and send it to stable mailing list to fix the bug.
- Fixes: 996133119f57 ("PM / devfreq: Add new passive governor")

Acked-by: Chanwoo Choi <cw00.choi@samsung.com> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
