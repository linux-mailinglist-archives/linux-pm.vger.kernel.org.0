Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A0F1165DA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 05:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfLIEhn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Dec 2019 23:37:43 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:11484 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLIEhm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Dec 2019 23:37:42 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191209043740epoutp010680ec0c7b5169db3393a02dbf7f30be~emgOqHjHa0859008590epoutp01f
        for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2019 04:37:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191209043740epoutp010680ec0c7b5169db3393a02dbf7f30be~emgOqHjHa0859008590epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575866260;
        bh=BcthN1hRlyG/lQR+ie9iS9jhZIV0Qs1l1qknEZj+eZw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QdpaVlOH/fAeVAz3HVI9Zoss3MeeX5PaOPvvIogqPSsUFkgijjqT+6e20AHOzyUzM
         lE+wcj4ZHggi5elLbdUmMD3R0RjOmVjEYBKGstGdp2FaAtACmzWYcC+xBJsVqU9LQN
         N7qcPNXBHIVd8TpVVUgYKEzSgjSn37ttrQoLAOlM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191209043739epcas1p1cb9934dd953e3b22fbaf764912f81ef7~emgONx4eo0349303493epcas1p1t;
        Mon,  9 Dec 2019 04:37:39 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47WVmK3ylYzMqYkZ; Mon,  9 Dec
        2019 04:37:37 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.D9.52419.B8FCDED5; Mon,  9 Dec 2019 13:37:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191209043731epcas1p266d81cfc4b1f2a8e9aee3b56f79bfc3d~emgGTd0dS1447014470epcas1p27;
        Mon,  9 Dec 2019 04:37:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191209043731epsmtrp28883d1f6a100cbb0e58592bf2f4146fd~emgGS5Lwf2373623736epsmtrp2Z;
        Mon,  9 Dec 2019 04:37:31 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-81-5dedcf8b72d6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.CB.10238.B8FCDED5; Mon,  9 Dec 2019 13:37:31 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191209043731epsmtip21e1cbbb715f577d6bd28be9afe081f14~emgGJZDCI0389303893epsmtip2X;
        Mon,  9 Dec 2019 04:37:31 +0000 (GMT)
Subject: Re: [PATCH] devfreq: fix multiple kernel-doc warnings
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d4ce2bc5-4a07-f4e8-dffc-ec8a2c120edb@samsung.com>
Date:   Mon, 9 Dec 2019 13:43:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <50975461-6dab-8f89-e802-b34ca06008f5@infradead.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHObvb9WqubtPcT4Nc16BcqLut6TKVIomBElLQi2xd3W2Ke7U7
        JQuiF77LNOixDCONzIhKxVIaghq2amWZET0gyMqkrXI9zJ673kX+9/m9zvd8z/kRmKwWjyEK
        LQ7WbmFMFB4m7uyLVyVU3/fmqlxDi7Se/e9DtEPdDbjWf6gfaZ/ta8G13ufHxSskuvYWpe5w
        RyvS+dvm5WCbi9IKWMbA2hWsJd9qKLQY06msdfpVek2yik6gl2lTKIWFMbPpVGZ2TsLqQlNA
        kVKUMKbiQCqH4TgqKSPNbi12sIoCK+dIp1ibwWRbZkvkGDNXbDEm5lvNqbRKtUQTaNxWVDDY
        VCOyHYvd2dp8B9+LPNFVKJQAcik0T+4TVaEwQkZeR3CrvlEiBOMIztYNBIOvCHz1Zfi/kera
        U8ERF4Kf/vEQviAjPyB41xPFcwSZAV33n0t4jiRLYbTqo4hnjNwI3qoWjGecVELP6JOpQ2eR
        82F44hXiWRqY7R0on8qLyQXQ97h+iueQ68HdeTDYMxvcJ0fEPIeSK+H3h6uYcL4cno40BrVi
        4Zq3ARMufReH0b49AmdCvadLLHAEjA10hAgcA36fK2hyN1xw9+O8SSArEHT0DEqEghp6zh0N
        CBABgXi43J0kpOdD14/TSNCdCb4vNRK+BUgpVJTJhJY4GHr5QiRwNDSVV+JHEOWc5sY5zYFz
        mgPnf7EzSNyKolgbZzayHG1TT//sNjS1jMqU6+jKvexeRBKICpcqUr25MglTwpWaexEQGBUp
        ba4by5VJDUzpLtZu1duLTSzXizSBx67DYubkWwOrbXHoac0StVqtXUona2iakkuJiQe5MtLI
        ONgilrWx9n9zIiI0Zi/asdUw1+4hZq2ZDD/waBxPibpCPdHp9JGq886Hm+JiX594+8KVPEM5
        1v9twcVLkd+t8uF3mev/6O6ligcay974Jr4srxyONi+Ul2StvZ3dXnvjvGVLzX65u8hVuPZm
        9StjSfqWEVGZf6bPq5Fvz1t8odxD6vLmuX+lfjZs0EvDqE+UmCtgaCVm55i/P/IKNaIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvG73+bexBpv7OSzONr1ht7i8aw6b
        xefeI4wWtxtXsFm8vTOdxYHVY/MKLY++LasYPT5vkgtgjuKySUnNySxLLdK3S+DKuLC4h6lg
        mnzFqiWn2RoYz0p2MXJySAiYSHT3z2bqYuTiEBLYzShxe9tcJoiEpMS0i0eZuxg5gGxhicOH
        iyFq3jJK/Ft6hRWkRljATmLn+TtgtohApcT3GbdYQGxmgQiJE3emsUE0TGGUeHb7N9hQNgEt
        if0vbrCB2PwCihJXfzxmBLF5gQYdOt4OFmcRUJE4fG0SmC0qECaxc8ljJogaQYmTM5+ALeAU
        cJT4934jM8QydYk/8y5B2eISt57MZ4Kw5SW2v53DPIFReBaS9llIWmYhaZmFpGUBI8sqRsnU
        guLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgKNHS3MF4eUn8IUYBDkYlHt4Km7exQqyJZcWV
        uYcYJTiYlUR4l0x8FSvEm5JYWZValB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKY
        LBMHp1QDo9hvGyHlx75Z9p8Mzn6PF7XsaL506e7U6C3r5npETOXo+XTJnW/mnfMuLKtvz/yw
        XFu46JhQ0v6L+5xvslSFLjtXw3ImyixHmLU94/Wuy1UvHugsXy398taXP2vri+sCnnl1ely7
        cGfVxFUh1X0VXEznFWykTZ4xVOar/GmSLDF8IX22fmtYsRJLcUaioRZzUXEiANz+cy+OAgAA
X-CMS-MailID: 20191209043731epcas1p266d81cfc4b1f2a8e9aee3b56f79bfc3d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209043427epcas4p434b7d48469d958c23c69eb743de2ade9
References: <CGME20191209043427epcas4p434b7d48469d958c23c69eb743de2ade9@epcas4p4.samsung.com>
        <50975461-6dab-8f89-e802-b34ca06008f5@infradead.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Thanks. But, You need to rebase it on updated devfreq-next or linux-next
after today. Because, when I applied it to updated devfreq-next
after released v5.5-rc1, the merge conflict happen.

Please rebase and resend it. 

Regards,
Chanwoo Choi

On 12/9/19 1:34 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warnings in devfreq files.
> Also fix a typo.
> 
> ../include/linux/devfreq.h:181: warning: Function parameter or member 'last_status' not described in 'devfreq'
> 
> ../drivers/devfreq/devfreq.c:1687: warning: bad line:         - Resource-managed devfreq_register_notifier()
> ../drivers/devfreq/devfreq.c:1723: warning: bad line:         - Resource-managed devfreq_unregister_notifier()
> ../drivers/devfreq/devfreq-event.c:355: warning: Function parameter or member 'edev' not described in 'devfreq_event_remove_edev'
> ../drivers/devfreq/devfreq-event.c:355: warning: Excess function parameter 'dev' description in 'devfreq_event_remove_edev'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/devfreq/devfreq-event.c |    4 ++--
>  drivers/devfreq/devfreq.c       |    4 ++--
>  include/linux/devfreq.h         |    3 ++-
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> --- linux-next-20191209.orig/drivers/devfreq/devfreq.c
> +++ linux-next-20191209/drivers/devfreq/devfreq.c
> @@ -1733,7 +1733,7 @@ static void devm_devfreq_notifier_releas
>  
>  /**
>   * devm_devfreq_register_notifier()
> -	- Resource-managed devfreq_register_notifier()
> + *	- Resource-managed devfreq_register_notifier()
>   * @dev:	The devfreq user device. (parent of devfreq)
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to be unregistered.
> @@ -1769,7 +1769,7 @@ EXPORT_SYMBOL(devm_devfreq_register_noti
>  
>  /**
>   * devm_devfreq_unregister_notifier()
> -	- Resource-managed devfreq_unregister_notifier()
> + *	- Resource-managed devfreq_unregister_notifier()
>   * @dev:	The devfreq user device. (parent of devfreq)
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to be unregistered.
> --- linux-next-20191209.orig/drivers/devfreq/devfreq-event.c
> +++ linux-next-20191209/drivers/devfreq/devfreq-event.c
> @@ -346,9 +346,9 @@ EXPORT_SYMBOL_GPL(devfreq_event_add_edev
>  
>  /**
>   * devfreq_event_remove_edev() - Remove the devfreq-event device registered.
> - * @dev		: the devfreq-event device
> + * @edev	: the devfreq-event device
>   *
> - * Note that this function remove the registered devfreq-event device.
> + * Note that this function removes the registered devfreq-event device.
>   */
>  int devfreq_event_remove_edev(struct devfreq_event_dev *edev)
>  {
> --- linux-next-20191209.orig/include/linux/devfreq.h
> +++ linux-next-20191209/include/linux/devfreq.h
> @@ -135,6 +135,7 @@ struct devfreq_stats {
>   *		devfreq.nb to the corresponding register notifier call chain.
>   * @work:	delayed work for load monitoring.
>   * @previous_freq:	previously configured frequency value.
> + * @last_status:	devfreq user device info, performance statistics
>   * @data:	Private data of the governor. The devfreq framework does not
>   *		touch this.
>   * @min_freq:	Limit minimum frequency requested by user (0: none)
> @@ -148,7 +149,7 @@ struct devfreq_stats {
>   * @stats:	Statistics of devfreq device behavior
>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>   *
> - * This structure stores the devfreq information for a give device.
> + * This structure stores the devfreq information for a given device.
>   *
>   * Note that when a governor accesses entries in struct devfreq in its
>   * functions except for the context of callbacks defined in struct
> 
> 
> 
