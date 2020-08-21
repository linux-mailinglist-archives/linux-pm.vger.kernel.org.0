Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB6124D0A2
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 10:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgHUIjv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 21 Aug 2020 04:39:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:51504 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727827AbgHUIjv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 04:39:51 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-267-_gpouvAZPXW8jiqY6_gXxA-1; Fri, 21 Aug 2020 09:39:46 +0100
X-MC-Unique: _gpouvAZPXW8jiqY6_gXxA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 21 Aug 2020 09:39:45 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 21 Aug 2020 09:39:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yue Hu' <zbestahu@gmail.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "zhangwen@yulong.com" <zhangwen@yulong.com>
Subject: RE: [PATCH] thermal: sysfs: Fall back to vmalloc() for cooling
 device's statistics
Thread-Topic: [PATCH] thermal: sysfs: Fall back to vmalloc() for cooling
 device's statistics
Thread-Index: AQHWd2T1s2XRZ72P6kCMdg6RVGFevalCPhSw
Date:   Fri, 21 Aug 2020 08:39:45 +0000
Message-ID: <7a0c2e488e024c0694fd730f95ba98fb@AcuMS.aculab.com>
References: <20200821024406.10404-1-zbestahu@gmail.com>
In-Reply-To: <20200821024406.10404-1-zbestahu@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu
> Sent: 21 August 2020 03:44
> 
> From: Yue Hu <huyue2@yulong.com>
> 
> We observed warning about kzalloc() when register thermal cooling device
> in backlight_device_register(). backlight display can be a cooling device
> since reducing screen brightness will can help reduce temperature.
> 
> However, ->get_max_state of backlight will assign max brightness of 1024
> to states. The memory size can be getting 1MB+ due to states * states.
> That is so large to trigger kmalloc() warning.

I can't help feeling that there is an 'adequate' implementation
that doesn't require anywhere near 1MB of memory.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

