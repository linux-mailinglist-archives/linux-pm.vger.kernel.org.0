Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E575B350C1C
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 03:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhDABvd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 21:51:33 -0400
Received: from smtp1.axis.com ([195.60.68.17]:10247 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233436AbhDABva (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Mar 2021 21:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1617241890;
  x=1648777890;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gl7EPpSLtrZnTMgtDD5JsRTYmYoIH6RbC6yuiOic6Vw=;
  b=Awh9KGXUH5lGdGuO1Z+DgdBqiy/lXGzp6ADd2qU7j+eOZZw+HD/Rx9vY
   FmcCKacyyF9eIJDtCR2JM14zaKKSkqCRxuR/rz8z78s17YDL2RazAiva9
   oL/PIU7uqvtXhIVhENAdGsRkhqYnNZsDIya6puzXNBWAEMHI75OO+Ljp7
   KAQdL8bTGKjQ4I68AgeDGl9KgUCF+oC26GLDXgf7m9s3Fv++2Q7CYShNC
   wUrpy49lTARYe8mq+ff7iAgBhaRm8UPu8IozZ6I7DRP2VrU4K1hZ6/ZiW
   JCbf8CLBQpr0E77M8J9hfn5P08svhAPJwwEAim0HB+guYkDvNX/Yw1bYS
   g==;
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Hermes Zhang <Hermes.Zhang@axis.com>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        Sebastian Reichel <sre@kernel.org>, kernel <kernel@axis.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: bq27xxx: Return the value instead of
 -ENODATA
Thread-Topic: [PATCH] power: supply: bq27xxx: Return the value instead of
 -ENODATA
Thread-Index: AQHXJjT9YXVQp+YZmUqmV5QFL6HFrQ==
Date:   Thu, 1 Apr 2021 01:51:28 +0000
Message-ID: <3acaabf2ec63418891e3f698c16b9a21@XBOX01.axis.com>
References: <20210331135141.8063-1-chenhui.zhang@axis.com>
 <20210331140238.jl3qprpqhqave4bf@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/31/21 10:02 PM, Pali Roh=E1r wrote:=0A=
> @@ -1655,9 +1655,6 @@ static int bq27xxx_battery_read_time(struct bq27xxx=
_device_info *di, u8 reg)=0A=
>  		return tval;=0A=
>  	}=0A=
>  =0A=
> -	if (tval =3D=3D 65535)=0A=
> -		return -ENODATA;=0A=
> -=0A=
>  	return tval * 60;=0A=
> I'm not sure if this is correct change. If value 65535 is special which=
=0A=
> indicates that data are not available then driver should not return=0A=
> (converted) value 65535*60. If -ENODATA is there to indicate that data=0A=
> are not available then -ENODATA should not be used.=0A=
>=0A=
> And if there is application which does not handle -ENODATA for state=0A=
> when data are not available then it is a bug in application.=0A=
=0A=
Yeah, I just have a feeling return -ENODATA for time_to_full/empty is=0A=
not good here. Because:=0A=
=0A=
1. From chip datasheet, it mentioned return 65535 when it's not=0A=
available (e.g. read time_to_full when discharging), but the driver=0A=
changes behavior here.=0A=
=0A=
2. There is other case will return -ENODATA (e.g. the gauge not=0A=
calibrated), so it will confuse application which is real failure.=0A=
=0A=
Could we change the value in minute instead of seconds in=0A=
bq27xxx_battery_read_time(), so that means driver do nothing but only=0A=
pass the value from the chip?=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Hermes=0A=
=0A=
=0A=
