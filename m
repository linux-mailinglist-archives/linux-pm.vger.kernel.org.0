Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCCA13AD42
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 16:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgANPQE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 10:16:04 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:47598 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgANPQE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 10:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1579014962; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kann6zCyNBbdeCYKcxlAxIyBSoLFOxdoAfrds4Ykqew=;
        b=m2bfD8zkD7c1NMMwpd4j5EvVeSrnaEjcN+Zirav8BO5gKVRc73sv4NiqrnLvmj9fUZ9rww
        tqLLASDOGtM1ES8AoU9N1o3/Ph2OERksgOoE0mCmt8XE4KT+HljF9mi1q+T2qWxRl4XH12
        119cIoASr+kLxZ+E8c8LvtBOD5lIWFQ=
Date:   Tue, 14 Jan 2020 12:15:48 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] usb: common: usb-conn-gpio: Register charger
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1579014948.3.0@crapouillou.net>
In-Reply-To: <1578536872.21256.25.camel@mhfsdcap03>
References: <20200107002901.940297-1-paul@crapouillou.net>
        <20200108165323.GA2506374@kroah.com> <1578504370.3.1@crapouillou.net>
        <1578536872.21256.25.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chunfeng,

Le jeu., janv. 9, 2020 at 10:27, Chunfeng Yun=20
<chunfeng.yun@mediatek.com> a =E9crit :
> Hi Paul,
>=20
> On Wed, 2020-01-08 at 14:26 -0300, Paul Cercueil wrote:
>>  Hi Greg,
>>=20
>>=20
>>  Le mer., janv. 8, 2020 at 17:53, Greg Kroah-Hartman
>>  <gregkh@linuxfoundation.org> a =E9crit :
>>  > On Tue, Jan 07, 2020 at 01:29:01AM +0100, Paul Cercueil wrote:
>>  >>  Register a power supply charger, whose online state depends on
>>  >> whether
>>  >>  the USB role is set to device or not.
>>  >
>>  > That says _what_ you are doing, but I have no idea _why_ you want=20
>> to
>>  > do
>>  > this.
>>  >
>>  > What is this going to cause to have happen?  What new userspace=20
>> api is
>>  > going to result?  What will a user do with this?
>>=20
>>  This is useful when the USB role is the only way to know if the=20
>> device
>>  is charging from USB.
> There is no charger IC on your platform?

Correct.

>=20
>>=20
>>  The API is the standard power supply charger API, you get a
>>  /sys/class/power_supply/xxx/online node which tells you the state of
>>  the charger.
>>=20
>>  The sole purpose of this is to give userspace applications a way to
>>  know whether or not the charger is plugged.
>>=20
>>  > Is this going to always show up, no matter if the role is not even
>>  > relevant for a power supply?
>>=20
>>  I guess it'd always show up, yes. In which case would the role not=20
>> be
>>  relevant for a power supply?
> Do you also need it if the platform don't have battery?

I guess not. Would you prefer it to be disabled by default? If so, what=20
would be the way to have it enabled? A flag in devicetree?

>=20
>>  Is gpio-b-connector not always used for
>>  OTG connectors?
> It also supports device only mode, usually uses vBus pin to
> enable/disable controller

Yes, that would work too. The problem would be a host-only=20
gpio-b-connector.

-Paul

=

