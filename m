Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C95079F58
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 05:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbfG3DCl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 23:02:41 -0400
Received: from anchovy2.45ru.net.au ([203.30.46.146]:36427 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732835AbfG3DCf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 23:02:35 -0400
Received: (qmail 342 invoked by uid 5089); 30 Jul 2019 03:02:33 -0000
Received: by simscan 1.2.0 ppid: 32701, pid: 32702, t: 0.3042s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on anchovy2
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=6.0 tests=ALL_TRUSTED,AWL
        autolearn=disabled version=3.4.1
Received: from unknown (HELO ?192.168.0.34?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 30 Jul 2019 03:02:32 -0000
Subject: Re: [PATCH 1/1] power: supply: sbs-battery: Add ability to force load
 a battery via the devicetree
To:     sre@kernel.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        rfontana@redhat.com, allison@lohutok.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nick Crews <ncrews@chromium.org>,
        Guenter Roeck <groeck@google.com>
References: <1564030601-14639-1-git-send-email-rtresidd@electromag.com.au>
From:   Richard Tresidder <rtresidd@electromag.com.au>
Message-ID: <5023c937-0662-57e0-c104-bb9c23b07a49@electromag.com.au>
Date:   Tue, 30 Jul 2019 11:02:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564030601-14639-1-git-send-email-rtresidd@electromag.com.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Nick and Guenter
Just adding you to this one also seeing as you're looking at that other 
sbs_battery patch for me.
Not sure why the get maintainers didn't list you for this one.

Cheers
    Richard Tresidder
> Add the ability to force load a hot pluggable battery during boot where
> there is no gpio detect method available and the module is statically
> built. Normal polling will then occur on that battery when it is inserted.
>
> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
> ---
>
> Notes:
>      Add the ability to force load a hot pluggable battery during boot where
>      there is no gpio detect method available and the module is statically
>      built. Normal polling will then occur on that battery when it is inserted.
>
>   drivers/power/supply/sbs-battery.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 048d205..ea8ba3e 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -161,6 +161,7 @@ struct sbs_info {
>   	int				poll_time;
>   	u32				i2c_retry_count;
>   	u32				poll_retry_count;
> +	bool				force_load;
>   	struct delayed_work		work;
>   	struct mutex			mode_lock;
>   	u32				flags;
> @@ -852,6 +853,9 @@ static int sbs_probe(struct i2c_client *client,
>   	if (rc)
>   		chip->poll_retry_count = 0;
>   
> +	chip->force_load = of_property_read_bool(client->dev.of_node,
> +						"sbs,force-load");
> +
>   	if (pdata) {
>   		chip->poll_retry_count = pdata->poll_retry_count;
>   		chip->i2c_retry_count  = pdata->i2c_retry_count;
> @@ -890,7 +894,7 @@ static int sbs_probe(struct i2c_client *client,
>   	 * Before we register, we might need to make sure we can actually talk
>   	 * to the battery.
>   	 */
> -	if (!(force_load || chip->gpio_detect)) {
> +	if (!(force_load || chip->gpio_detect || chip->force_load)) {
>   		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
>   
>   		if (rc < 0) {

