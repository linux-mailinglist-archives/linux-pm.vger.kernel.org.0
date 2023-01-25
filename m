Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5741B67B2E8
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 14:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjAYNCz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 08:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbjAYNCw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 08:02:52 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6745FF6
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 05:02:47 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D236D84EEF;
        Wed, 25 Jan 2023 14:02:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1674651765;
        bh=VGk4cckp0DzPBXXnldmKHTV0LVEUT9amYPhZ/Y7NPM0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qyV52cmt+GzhhzvJ+8jMAM/fEzR1CRTSZ2L4jG81xPj7iwgFODNEW5wuMa8P/ERZX
         uuMYMyxV7edVKXviSpYrk4bbclvQOf2QLk1nS6HhQeZlAoyLEgV5r4BHrINQCp4Daa
         l89rNg6yX1b12arKI9iPdOKeauifmdOPcW4pybfjGV7Lj3jLuG4VXgIIH+m5nL3Tm3
         DeOHsdqYLMIZjuM2mEQbqBOhWWifAtQXQ8Piglug3qnuNWsJcyhwb3jX7LvUaoYOdJ
         Y2Ym39+wdQs1uh5KnEKTveKD+aKzo0g7nTHplKGCS1PIkN9GXcYLb9N8EYBzl+ZhnS
         hflOSWX/TApRg==
Message-ID: <bce44755-9a27-74e4-47ae-ee8051780575@denx.de>
Date:   Wed, 25 Jan 2023 14:02:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] power: supply: bq25890: Add new
 linux,iinlim-percentage property
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20230125105850.17935-1-hdegoede@redhat.com>
 <20230125105850.17935-3-hdegoede@redhat.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230125105850.17935-3-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/25/23 11:58, Hans de Goede wrote:

[...]

> @@ -1390,6 +1404,17 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
>   	device_property_read_u32(bq->dev, "linux,pump-express-vbus-max",
>   				 &bq->pump_express_vbus_max);
>   
> +	ret = device_property_read_u32(bq->dev, "linux,iinlim-percentage", &val);
> +	if (ret == 0) {
> +		if (val > 100) {
> +			dev_err(bq->dev, "Error linux,iinlim-percentage %u > 100\n", val);
> +			return -EINVAL;
> +		}
> +		bq->iinlim_percentage = val;
> +	} else {
> +		bq->iinlim_percentage = 100;
> +	}

Should we really return -EINVAL if > 100 % or shall we clamp the value 
instead ?
