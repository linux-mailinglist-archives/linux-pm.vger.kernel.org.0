Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59359B88D2
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 03:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392814AbfITBLf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 21:11:35 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:34476 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390887AbfITBLf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 21:11:35 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190920011132epoutp016c06a5f71e8083f45d25dbd061f4caf0~GAFa2JyJL3124331243epoutp017
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2019 01:11:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190920011132epoutp016c06a5f71e8083f45d25dbd061f4caf0~GAFa2JyJL3124331243epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568941892;
        bh=NSUo9i+kQt0hNblsLn1wFiMctqsDJi8mWqdj2EhUB/c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tEZ6djmiLuzNJ08iFIyYdWdrmuGTjVxqY2PxWPv/2aVn6ZmdPdf6PHDbi9CLoyfoe
         60WfbDsBuaavsCXnCUZGbQ0OjuX+T9NjrVjipM55vJecuDg6y38B5dH2IAFv15+HOQ
         e4D8MP79yYJUjweHy2wmtuBUvPSMZssB5xxdUq04=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190920011131epcas1p485a4f11873912b5ab75f13a3366a4b52~GAFaIHwI30839608396epcas1p4Z;
        Fri, 20 Sep 2019 01:11:31 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46ZFzP4XWfzMqYkZ; Fri, 20 Sep
        2019 01:11:29 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.32.04066.147248D5; Fri, 20 Sep 2019 10:11:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190920011129epcas1p297a9ecd11256e1183281f4f1a93f8056~GAFXkmkA10549505495epcas1p2d;
        Fri, 20 Sep 2019 01:11:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190920011129epsmtrp15447108d2a4daf9062909e2168a83930~GAFXjyA5b2091320913epsmtrp1F;
        Fri, 20 Sep 2019 01:11:29 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-bc-5d842741a964
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.0E.03706.047248D5; Fri, 20 Sep 2019 10:11:28 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190920011128epsmtip12d6b5f591beff0d870a25d0f030d0e19~GAFXVtxSj3257932579epsmtip15;
        Fri, 20 Sep 2019 01:11:28 +0000 (GMT)
Subject: Re: [PATCH v2] devfreq: Add tracepoint for frequency changes
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <62b2228b-e198-2558-2afc-e5687935742b@samsung.com>
Date:   Fri, 20 Sep 2019 10:15:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919174423.105030-1-mka@chromium.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmrq6jekuswYUdyhZnlx1kszjb9Ibd
        4vKuOWwWn3uPMFpcOrCAyeLzhseMFrcbV7BZ7Ot4wOTA4TG74SKLR8u+W+we7/ddZfPo27KK
        0ePzJrkA1qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23
        zBygW5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BZYFesWJucWleel6yfm5VoYG
        BkamQIUJ2RldD5YyFbwQqpixu5GtgXErfxcjJ4eEgIlEy/NWli5GLg4hgR2MEtNO7maEcD4x
        Skz/0cUM4XxjlHg6fRU7TEvrqTZGEFtIYC+jxPE5/BBF7xkl+s9tYgZJCAu4SmxdB9EtInCM
        UeLmw9NgCWaBNInXj3+BTWIT0JLY/+IGG4jNL6AocfXHY7CpvAJ2Ei2PXjKB2CwCqhL9j/ey
        gNiiAhESnx4cZoWoEZQ4OfMJWJxTwFziyMQpTBDzxSVuPZkPZctLNG+dDXaEhMBnNoknTzZA
        veAi0XfgGQuELSzx6vgWqLiUxMv+Nii7WmLlySNsEM0djBJb9l9ghUgYS+xfOhloAwfQBk2J
        9bv0IcKKEjt/z2WEWMwn8e5rDytIiYQAr0RHmxBEibLE5Qd3mSBsSYnF7Z1sExiVZiF5ZxaS
        F2YheWEWwrIFjCyrGMVSC4pz01OLDQuMkaN7EyM4oWqZ72DccM7nEKMAB6MSD69CeXOsEGti
        WXFl7iFGCQ5mJRHeOaZNsUK8KYmVValF+fFFpTmpxYcYTYGhPZFZSjQ5H5js80riDU2NjI2N
        LUwMzUwNDZXEeT3SG2KFBNITS1KzU1MLUotg+pg4OKUaGHOElt0P41z13VYw/OxBPXUTjVcs
        qVyLDX/ftl5//V5F97/Q9Vde7GvtniATet1j4wHxlif2E48vuvk9yktBde+XK1u0dyu+7bcp
        ZZ7G/3Hqtzl8Hurb3z+qfbwtfN7O9xyy/4OkPvbuC4t9OvXcf1eP+EMrJnWbGt7OFLz3mstb
        LvzquTvnytKUWIozEg21mIuKEwH1AM6pvgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSnK6DekuswY8VVhZnlx1kszjb9Ibd
        4vKuOWwWn3uPMFpcOrCAyeLzhseMFrcbV7BZ7Ot4wOTA4TG74SKLR8u+W+we7/ddZfPo27KK
        0ePzJrkA1igum5TUnMyy1CJ9uwSujK4HS5kKXghVzNjdyNbAuJW/i5GTQ0LARKL1VBtjFyMX
        h5DAbkaJu9/+MkIkJCWmXTzK3MXIAWQLSxw+XAxR85ZR4uK8P+wgNcICrhJb13Uxg9giAicY
        JQ78ZAKxmQXSJDYs38cO0dDFKLH20FqwBJuAlsT+FzfYQGx+AUWJqz8egy3jFbCTaHn0EqyG
        RUBVov/xXhYQW1QgQuLwjllQNYISJ2c+AYtzCphLHJk4BWqZusSfeZeYIWxxiVtP5kPF5SWa
        t85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZw
        ZGlp7mC8vCT+EKMAB6MSD69CeXOsEGtiWXFl7iFGCQ5mJRHeOaZNsUK8KYmVValF+fFFpTmp
        xYcYpTlYlMR5n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUwZj6bM9k4pzXytFlxWWPa3T+H1pvq
        Bqzp+XDdtLD3+mIZHmPJv0sZrB8ed5D7u2nrqZT5jVpxXYvtovztHTw8LqcGLVojJO/aFdlh
        qq0pXhjqtuy+TTXrh0CuB1u2Kk/tSL6s9kjt8y2xpA+BZe6PnV6c3iR+3r/1dfAKzzOcjUrH
        j6yu6J+vxFKckWioxVxUnAgAVlpu96gCAAA=
X-CMS-MailID: 20190920011129epcas1p297a9ecd11256e1183281f4f1a93f8056
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190919174436epcas4p17bf0528950813d3326237fcc56fd9b21
References: <CGME20190919174436epcas4p17bf0528950813d3326237fcc56fd9b21@epcas4p1.samsung.com>
        <20190919174423.105030-1-mka@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 20. 오전 2:44, Matthias Kaehlcke wrote:
> Add a tracepoint for frequency changes of devfreq devices and
> use it.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> (sending v2 without much delay wrt v1, since the change in devfreq
>  probably isn't controversial, and I'll be offline a few days)
> 
> Changes in v2:
> - included trace_devfreq_frequency_enabled() in the condition
>   to avoid unnecessary evaluation when the trace point is
>   disabled
> ---
>  drivers/devfreq/devfreq.c      |  3 +++
>  include/trace/events/devfreq.h | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index ab22bf8a12d6..e9f04dcafb01 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -317,6 +317,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>  
>  	devfreq->previous_freq = new_freq;
>  
> +	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
> +		trace_devfreq_frequency(devfreq, new_freq);

You can change as following without 'new_freq' variable
because devfreq->previous_freq is the new frequency.	
	trace_devfreq_frequency(devfreq);

> +
>  	if (devfreq->suspend_freq)
>  		devfreq->resume_freq = cur_freq;
>  
> diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
> index cf5b8772175d..a62d32fe3c33 100644
> --- a/include/trace/events/devfreq.h
> +++ b/include/trace/events/devfreq.h
> @@ -8,6 +8,24 @@
>  #include <linux/devfreq.h>
>  #include <linux/tracepoint.h>
>  
> +TRACE_EVENT(devfreq_frequency,
> +	TP_PROTO(struct devfreq *devfreq, unsigned long freq),

'unsigned long freq' parameter is not necessary.

> +
> +	TP_ARGS(devfreq, freq),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name(&devfreq->dev))
> +		__field(unsigned long, freq)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name(&devfreq->dev));
> +		__entry->freq = freq;

Initialize the new frequency with 'devfreq->previous_freq' as following:

		__entry->freq = devfreq->previous_freq;

> +	),
> +
> +	TP_printk("dev_name=%s freq=%lu", __get_str(dev_name), __entry->freq)
> +);
> +
>  TRACE_EVENT(devfreq_monitor,
>  	TP_PROTO(struct devfreq *devfreq),
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
