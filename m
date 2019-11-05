Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A81EF43B
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 04:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbfKED40 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 22:56:26 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:18184 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387443AbfKED40 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 22:56:26 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191105035622epoutp02d182a800f31aa2451e1757bb897ea9de~UKAdjEXq43164231642epoutp02f
        for <linux-pm@vger.kernel.org>; Tue,  5 Nov 2019 03:56:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191105035622epoutp02d182a800f31aa2451e1757bb897ea9de~UKAdjEXq43164231642epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572926182;
        bh=FyerKIyfVgfyjJOqIQrQpBn4PpuXMSg7kowgsAT+ez8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pvs/y7ghk09Bln9WZouhJt1Jo1jH5PlbOhTqzY9VJAeXc7lfFBbSFK/vT3dB7iKyV
         MngIK5GQd2qslZubQaYuT4Z28GSpmu1dykABmOXX/j8ANgs4wjBGhcmQXjfzJuE6th
         QCwTw2K1CXL4H9gOc7pYsAtEzwzS6FF7OQ9XQ5aU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191105035621epcas1p124a08e517c255b8bf8bbad29abe788b0~UKAc_6BQx3228132281epcas1p16;
        Tue,  5 Nov 2019 03:56:21 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 476bSM1jRXzMqYkV; Tue,  5 Nov
        2019 03:56:19 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.48.04135.ED2F0CD5; Tue,  5 Nov 2019 12:56:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191105035613epcas1p208f7557d6b745715d5dae78be40b83bb~UKAV7_bB62831028310epcas1p2U;
        Tue,  5 Nov 2019 03:56:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191105035613epsmtrp19baf2e131a5043589a487e1639e4e8ec~UKAV7MJgE2073120731epsmtrp12;
        Tue,  5 Nov 2019 03:56:13 +0000 (GMT)
X-AuditID: b6c32a36-7e3ff70000001027-09-5dc0f2de27f1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.41.24756.DD2F0CD5; Tue,  5 Nov 2019 12:56:13 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191105035613epsmtip12cc4a74fb2ab350c0426876232c29879~UKAVjI3L32448224482epsmtip1K;
        Tue,  5 Nov 2019 03:56:13 +0000 (GMT)
Subject: Re: [PATCH v9 16/19] PM / devfreq: Add new interrupt_driven flag
 for governors
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e6308af7-97c8-3d1d-5072-a8ec3c478e6e@samsung.com>
Date:   Tue, 5 Nov 2019 13:01:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104215617.25544-17-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0hTYRjm2+bZ0VqdNi9v/qh5ikzJy9FmR0kpklhpJd2wYtjBnVTcjZ0Z
        Xf5YxrRI07LbWlmWaJoZtnSObKaSlRjaisRYBK2bhFlmFFa07Rj573nf53kvz3fBhdJOLBwv
        0JlYo47RkFiQqK0nKjbm1dcuVXzLGSnd9OUNoo9YakX0wOFPYtrlsGL0RHkvoo9+s2D09/eP
        Ef3yUANGD7zLoH86Lonoiuan2KpZSrv7GlJ2WNxiZXnJGKa0mO9hygpbI1JOtC7IwnYWrsxn
        GTVrlLO6XL26QJeXSmZsyVmTo0iKp2KoZHoFKdcxWjaVTM/MillboPGuR8r3MpoibyqL4Tgy
        Lm2lUV9kYuX5es6USrIGtcaQbIjlGC1XpMuLzdVrU6j4+ASFV7i7ML//9bMAQ9+CfaXFacWo
        dP4xFIgDsRyuNNxGx1AQLiXsCJwTt4R88BWBy2ObDr4jcPx6gP6VDPdUCHiiE8HZG5PTwWcE
        7X0tYp9KRuyAt9V3MB8RTHgE0Nl7ROQjhF6ip6NJ4MMYEQ3OD8OYD88lIuD5jzf+ERIiDSpd
        Hn9eRCyGvpIurx7HQ4hs6J9keMk8eHTe428ZSKyA3l/PBXz7MBjx1EzjhVBy54LfAhAnxGAu
        qRLyFtLB1szvA4QMRvtsYh6Hw8cT5ml8EK4/6sX44jIENudgAE8kgrPulH8hIREFLY44Ph0B
        HVMXET94DoxNHg/wSYCQQJlZyksWgeu1W8Dj+XC19ChWiUjLDDuWGRYsMyxY/g+7jESNKJQ1
        cNo8lqMMCTNvuxX5n250kh3VPsnsRgSOyNmS8dIulTSA2cvt13YjwIVksGToXKdKKlEz+w+w
        Rn2OsUjDct1I4T3sKmF4SK7e+xF0phxKkZCYmEgvp5IUFEWGSVbX16mkRB5jYgtZ1sAa/9UJ
        8MDwYtRQtqNycHWtcplpbGhDT2zgVEG9fdfN0+5sSrsd3UsXKarco8ZPL7ZlblKPTKyP3PRn
        nizIej+y7nf7aHVwZvXU5iXWQ3aVzLzVmexaI7eFpqwrb5QNzNkY+q0tpVBTP77U3RF3IQxz
        fL5bHaw4mf30dFCEIXl9jetU6B6r9aD9ISni8hkqWmjkmL/FXZW40AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSnO7dTwdiDeZt0bNY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLL49P8VocbtxBZvF2WfeFj93zWOx6Ft7ic2B22PH3SWM
        Hjtn3WX36G1+x+Yxq20fm0ffllWMHp83yQWwRXHZpKTmZJalFunbJXBlnH5whbXguFxFe4Nd
        A2O7ZBcjJ4eEgInEjcN9TF2MXBxCArsZJRasa2GCSEhKTLt4lLmLkQPIFpY4fLgYouYto8S8
        1+1sIDXCApESbeu/M4IkRASeMUks3LsTrJkZKNEzdwtYkZDANkaJEy1+IDabgJbE/hc3wOL8
        AooSV388ZgSxeQXsJCZcfgIWZxFQkTjefABsjqhAhMTz7TegagQlTs58wgJicwqYSxz5cxVq
        l7rEn3mXmCFscYlbT+ZDxeUlmrfOZp7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGB
        YV5quV5xYm5xaV66XnJ+7iZGcPRpae5gvLwk/hCjAAejEg/vh/YDsUKsiWXFlbmHGCU4mJVE
        eC/O2BsrxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdp3rFIIYH0xJLU7NTUgtQimCwTB6dUA2P6
        sTVWb1Y9Psw/R2Jr9ynhUJ7T+jwdLxdMeiN6v3nbq3ymiidvn25dI8u2iuO5SYJnfzhLiEKe
        v5DyieTl6358urD1nPC8cO3C7vuvnG5nbrf+1lf+Mdfv+Cz2SoEZohL7ztVI6InpKG3QXzWL
        6/8ubo+WqM8psf/ZT+5ZrPtjbcaJKnXJPQuUWIozEg21mIuKEwHVZdLrugIAAA==
X-CMS-MailID: 20191105035613epcas1p208f7557d6b745715d5dae78be40b83bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191104221911epcas1p4d0e4fd0f12e746da7ac4e462619b2bd9
References: <20191104215617.25544-1-digetx@gmail.com>
        <CGME20191104221911epcas1p4d0e4fd0f12e746da7ac4e462619b2bd9@epcas1p4.samsung.com>
        <20191104215617.25544-17-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 19. 11. 5. 오전 6:56, Dmitry Osipenko wrote:
> Currently interrupt-driven governors (like NVIDIA Tegra30 ACTMON governor)
> are used to set polling_ms=0 in order to avoid periodic polling of device
> status by devfreq core. This means that polling interval can't be changed
> by userspace for such governors.
> 
> The new governor flag allows interrupt-driven governors to convey that
> devfreq core shouldn't perform polling of device status and thus generic
> devfreq polling interval could be supported by these governors now.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/devfreq.c  | 17 +++++++++++++++++
>  drivers/devfreq/governor.h |  3 +++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index b905963cea7d..4eff37e8bb07 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -409,6 +409,9 @@ static void devfreq_monitor(struct work_struct *work)
>   */
>  void devfreq_monitor_start(struct devfreq *devfreq)
>  {
> +	if (devfreq->governor->interrupt_driven)
> +		return;
> +
>  	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>  	if (devfreq->profile->polling_ms)
>  		queue_delayed_work(devfreq_wq, &devfreq->work,
> @@ -426,6 +429,9 @@ EXPORT_SYMBOL(devfreq_monitor_start);
>   */
>  void devfreq_monitor_stop(struct devfreq *devfreq)
>  {
> +	if (devfreq->governor->interrupt_driven)
> +		return;
> +
>  	cancel_delayed_work_sync(&devfreq->work);
>  }
>  EXPORT_SYMBOL(devfreq_monitor_stop);
> @@ -453,6 +459,10 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
>  	devfreq_update_status(devfreq, devfreq->previous_freq);
>  	devfreq->stop_polling = true;
>  	mutex_unlock(&devfreq->lock);
> +
> +	if (devfreq->governor->interrupt_driven)
> +		return;
> +
>  	cancel_delayed_work_sync(&devfreq->work);
>  }
>  EXPORT_SYMBOL(devfreq_monitor_suspend);
> @@ -473,11 +483,15 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  	if (!devfreq->stop_polling)
>  		goto out;
>  
> +	if (devfreq->governor->interrupt_driven)
> +		goto out_update;
> +
>  	if (!delayed_work_pending(&devfreq->work) &&
>  			devfreq->profile->polling_ms)
>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
> +out_update:
>  	devfreq->last_stat_updated = jiffies;
>  	devfreq->stop_polling = false;
>  
> @@ -509,6 +523,9 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>  	if (devfreq->stop_polling)
>  		goto out;
>  
> +	if (devfreq->governor->interrupt_driven)
> +		goto out;
> +
>  	/* if new delay is zero, stop polling */
>  	if (!new_delay) {
>  		mutex_unlock(&devfreq->lock);
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index bbe5ff9fcecf..dc7533ccc3db 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -31,6 +31,8 @@
>   * @name:		Governor's name
>   * @immutable:		Immutable flag for governor. If the value is 1,
>   *			this govenror is never changeable to other governor.
> + * @interrupt_driven:	Devfreq core won't schedule polling work for this
> + *			governor if value is set to 1.
>   * @get_target_freq:	Returns desired operating frequency for the device.
>   *			Basically, get_target_freq will run
>   *			devfreq_dev_profile.get_dev_status() to get the
> @@ -49,6 +51,7 @@ struct devfreq_governor {
>  
>  	const char name[DEVFREQ_NAME_LEN];
>  	const unsigned int immutable;
> +	const unsigned int interrupt_driven;
>  	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>  	int (*event_handler)(struct devfreq *devfreq,
>  				unsigned int event, void *data);
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
