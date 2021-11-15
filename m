Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA95C4508E5
	for <lists+linux-pm@lfdr.de>; Mon, 15 Nov 2021 16:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhKOPvW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 10:51:22 -0500
Received: from li1434-30.members.linode.com ([45.33.107.30]:46206 "EHLO
        node.akkea.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232412AbhKOPvJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Nov 2021 10:51:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 22F145DE02D;
        Mon, 15 Nov 2021 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1636991291; bh=ac3GT/m2JxRJik/OdVDww38ZqHjRJjailk8SaFnQFAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=uFdxBilAYAFRbRJD6urCr9FZ2B/Wku1J1Un9ztfy2/iHnsD6SSjLJsCpSq+d3FFAd
         uUqEuXbXAg0SbSTiS609yZ2oo38WIY/cEAbp0/RY0xM9rskXwfwBH45pSwaan1KjJJ
         0I6paF5d0uLGDH9KynjQG0BKf1sFx7BvXQ3dREpk=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ccp0qYPWq9XG; Mon, 15 Nov 2021 15:48:10 +0000 (UTC)
Received: from www.akkea.ca (li1434-30.members.linode.com [45.33.107.30])
        by node.akkea.ca (Postfix) with ESMTPSA id 53ADB5DE01D;
        Mon, 15 Nov 2021 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1636991290; bh=ac3GT/m2JxRJik/OdVDww38ZqHjRJjailk8SaFnQFAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=wnaZjsSVRCX0xOdxnsZGnVLgeLL9h9vR5Ta2qT4zJSp5e3mIa37rNEpjEm4R4TYH0
         P+4ytDRW6HGShmBCfSAjcI+YuCg8mqOfyBZrtFm6KI4BvBT4aJ6HTs2xrJS7/FpAUp
         Tzfqr5w2jiiRADaXjqYlvxrCcyOtDvpcNcTXO41M=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Nov 2021 07:48:10 -0800
From:   Angus Ainslie <angus@akkea.ca>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH] power: bq25890: temperature is also an adc value
In-Reply-To: <20211115152221.izjh36qlmlw5mbf6@earth.universe>
References: <20211110002440.71404-1-angus@akkea.ca>
 <20211115152221.izjh36qlmlw5mbf6@earth.universe>
Message-ID: <691151b347c64939bc0c407e8bf8bd75@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-11-15 07:22, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Nov 09, 2021 at 04:24:40PM -0800, Angus Ainslie wrote:
>> Make sure that a conversion is forced when the power supply is offline 
>> so
>> the temperature is valid.
>> 
>> Signed-off-by: Angus Ainslie <angus@akkea.ca>
>> ---
> 
> Thanks, queued to power-supply's fixes branch.
> 
> -- Sebastian
> 

Thanks !

Angus

>>  drivers/power/supply/bq25890_charger.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/power/supply/bq25890_charger.c 
>> b/drivers/power/supply/bq25890_charger.c
>> index 945c3257ca93..23a91c5d1f9d 100644
>> --- a/drivers/power/supply/bq25890_charger.c
>> +++ b/drivers/power/supply/bq25890_charger.c
>> @@ -388,6 +388,7 @@ static bool bq25890_is_adc_property(enum 
>> power_supply_property psp)
>>  	switch (psp) {
>>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>> +	case POWER_SUPPLY_PROP_TEMP:
>>  		return true;
>> 
>>  	default:
>> --
>> 2.25.1
>> 
