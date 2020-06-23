Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F655204F0F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 12:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbgFWKdO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 06:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731158AbgFWKdN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 06:33:13 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB672072E;
        Tue, 23 Jun 2020 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592908393;
        bh=7wQI3EJ/wW63CXeUks2SdMxBsWFVW+i++WGKoe+xuH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RMXumB3LOF0ID+gYZE58sAb4Kc4tTiXH9Y1OJpHUMxdbS19+pgqTUIUksM6gJKmxy
         PlLoLuAHf1fJX7hWO0vXRtz6XeIvyBGwRwdcIMYxmvIxDYFubSgMnWJpW7fbHpu8WK
         WIXupN7g+pFe4ohplPtoAOARu6rH+eANY2Z1yED4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jngEp-005efD-Or; Tue, 23 Jun 2020 11:33:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 23 Jun 2020 11:33:11 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: rk3399_dmc: Fix kernel oops when
 rockchip,pmu is absent
In-Reply-To: <7555251.hpBSmtosxn@diego>
References: <20200613102435.1728299-1-maz@kernel.org>
 <3900410.KmKVo4a8Xk@diego> <5d8101c2c9f6c4b965641dadbaf837e8@kernel.org>
 <7555251.hpBSmtosxn@diego>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <4d623262e58f38fb466f5f58c22321b2@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: heiko@sntech.de, enric.balletbo@collabora.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-06-23 09:55, Heiko Stübner wrote:
> Am Montag, 22. Juni 2020, 17:07:52 CEST schrieb Marc Zyngier:

[...]

>> maz@fine-girl:~$ sudo dtc -I dtb /sys/firmware/fdt 2>/dev/null | grep 
>> -A
>> 5 dmc
>> 	dmc {
>> 		u-boot,dm-pre-reloc;
>> 		compatible = "rockchip,rk3399-dmc";
>> 		devfreq-events = <0xc8>;
>> 
>> [followed by a ton of timings...]
>> 
>> It is definitely coming from u-boot (I don't provide any DTB 
>> otherwise,
>> and you can find the corresponding node and timings in the u-boot 
>> tree).
> 
> which is probably the source of the problem :-) .
> 
> I'm pretty sure the "reviewed" binding in the kernel doesn't match the
> dt-nodes used in uboot.

and the driver doesn't match the binding either. Frankly, this is badly
messed up.

> While u-boot these days syncs the main devicetrees from Linux, the 
> memory
> setup stuff is pretty specific to uboot (and lives in separate dtsi 
> files).
> 
> And I guess you're the only one feeding uboot's dtb to Linux directly, 
> hence
> nobody else did encounter this before ;-) .

I'm not "feeding" it directly. I'm using the expected DT distribution
mechanism, which is the boot firmware. Nobody should ever have to 
provide
their own DT to the kernel.

Thanks,

         M. (starting to like ACPI more and more every day)
-- 
Jazz is not dead. It just smells funny...
