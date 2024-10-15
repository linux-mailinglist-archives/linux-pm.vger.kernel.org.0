Return-Path: <linux-pm+bounces-15675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6436C99F372
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 18:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B78B22F84
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6421F76D1;
	Tue, 15 Oct 2024 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJr6EZco"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B81B395A;
	Tue, 15 Oct 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011253; cv=none; b=huIDXbrBlii1jjGqgRwxPlHO9lW9eqZ+u7BvVyK1403G0PIAPLaZMz4vBsOlDPaSlc8pqJx/YLhpzaWxyWLAshqptwzIYjNyJTqisUgkjKmgY4RzC3OMIPPrpMhtElHLWkJsXtoBFEDfwemmTRI7n1Yp6Ny6nb9hBbaBpOF5rSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011253; c=relaxed/simple;
	bh=jt9h5yy6eqjIkS52KhJItgoeHxABIFR0ZcnIr0QHuOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CknYbW2IoMzrO2IqzxkgkO+Z+/0ElSH4hTPJ1/02yFMxSBAoP1FsTsgdBKvRYCGX0sy6kP34zX60ZB6Sex+lZj71p8Rg5C/voj6nbiH6jJtGgipiSojJm4XzrANXnWarUyal3qHvnZKV84bOKU2ZMs4SlTyOTrZuAW80HqO3JaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJr6EZco; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cb47387ceso31923245ad.1;
        Tue, 15 Oct 2024 09:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729011251; x=1729616051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RwTex7FviFYJz5sLWbmH4GtUxr/U4LsBg1hljps6FSQ=;
        b=dJr6EZcoNXIhvtIBVFhTAztiy6f3SC0U5GirjWUr79S5HmUQzt4y88q0q2qDLatcul
         Gs3zhFbdjXcxiePpemN5DNamluWvP+Gg/uhz/K9h0LjF96M7/amMJgj1V/fFB+B25nmi
         Xo0xJ5Cxhtoe/+xiYdsTlXD+6u4Hq+7iB4uuSoO9xZ4CSn4DJyNi5hWKM7gGTyFOX+7Y
         GvTmONelV3TmL6ayJcBkmdLqG40mH5mtFVmh2L3BFN4yjH9M2auKSbUbZSHa20JWFvRK
         1Q52kXkWHjy7okQF0T38yV6SfVjUSpwAmEx2FonQhzTF13MR+VFqHJvq/KLDHr42SeVV
         BEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729011251; x=1729616051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwTex7FviFYJz5sLWbmH4GtUxr/U4LsBg1hljps6FSQ=;
        b=UbyWszVXePkF5sKtE2BPrSGC44YtbNmbEUBHL9k/eGSp8B7y1DcHxUlj0qChFgRRzo
         3llixyYIQLealMaUk/H7fV5Lq0N7zkGPS0uECK4FJfWQhmubU9ffqwTvIHx1E7F8nctR
         y+A9+PPN8rDs3fnLUnJcg5N6KaBZq6OVgr+rh5ClTHeMerCCZHtlN098HcpGjENDuH/t
         0lODYkk2sgAVL7z5TlpYKfOOn12tVnIdltENPzuPA9Gs2Axv+LL5kKvOeRQ2nFSDLIDw
         3V/1HC0YT+v/5onkEcn14oV+2JSEJr/9dKrTADaRY3XE64OK0BJonXMTPbL/kzZhsdK7
         9TQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkWjobtDV1apVGNwKjc7qUH0XVaIbfGjET9ng/ScMDSlfG0UhXFOLmJOVOccvYIZAKYCRPPQYRNt+Lb/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPa/2RWd3ACEfNzCp/b9l185uRfFLCNrsKyap7zeEpG9dozXl
	icME7jrAk/mQtZNdNQrMGggEwdeUSt+Vjoqfo+iOoVLyVJRx3PMyD+qcqVRsWXQNnuWpMh3ytwL
	z6RpzbNt0F3AQxiHTpCsC2eoA6W4=
X-Google-Smtp-Source: AGHT+IGkygX7FPX/Gs/LIewATbpr3nsPvCCqvjGWnOCESli1T2V9nHCDGVuO1CWstDpQszhvxIcwkYAEfhUVN4snN3w=
X-Received: by 2002:a17:902:db02:b0:20c:bffe:e1e5 with SMTP id
 d9443c01a7336-20d27ea8667mr12139375ad.19.1729011250853; Tue, 15 Oct 2024
 09:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
 <CAO6a-9-Gd44qiM7obURXwd8hrarZQ_8BpdbQPWQojh+yhO4oRw@mail.gmail.com>
 <5055c0ce-00cb-4319-beac-650436d4ad15@arm.com> <CAO6a-99xVXE-XgnRWMCK5OPC3aYCvhJoGqEbxJOGGy8-yK7W8g@mail.gmail.com>
 <8421fc1b-3d92-4f54-944f-6a612e5741dc@arm.com> <CAO6a-99bfA8+23cjg_x-9dBn_bEUsR5K9CS5D5L50YsgC3zavg@mail.gmail.com>
In-Reply-To: <CAO6a-99bfA8+23cjg_x-9dBn_bEUsR5K9CS5D5L50YsgC3zavg@mail.gmail.com>
From: Vivek yadav <linux.ninja23@gmail.com>
Date: Tue, 15 Oct 2024 22:23:59 +0530
Message-ID: <CAO6a-9-_vZqHxdcR7gBGCb=bORBCfujW=ro4-BOM=fZDd68zpA@mail.gmail.com>
Subject: Re: Fwd: ARM64: CPUIdle driver is not select any Idle state other
 then WFI
To: Christian Loehle <christian.loehle@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"krzk@kernel.org" <krzk@kernel.org>, linux-newbie@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christian,
> My guess would be that state1 can't be entered, i.e.
> entered_state = target_state->enter(dev, drv, index);
> returns < 0, in that case the sysfs 'rejected' field
> will be incremented instead of usage and time.
> Is that the case for you?

Yes, I checked your guess was correct. ``enter_state`` value equals to Zero.

``#cat /sys/devices/system/cpu/cpu*/cpuidle/state*/rejected``
0 ==> state_0 CPU(0)
0 ==> state_1 CPU(0)
0 ==> state_0 rejected values CPU(1)
600117 ==> state_1 increasing values CPU(1)
0
854505
0
41756644

> In that case your psci description is probably wrong
> and doesn't match your system.

What do you mean by ``psci`` description ?

I have one node in the device  tree file.

psci {
     compatible = "arm,psci-1.0";
     method = "smc";
};

Please find some logs. I am not able to conclude much by seeing the below logs.

#dmesg | grep "PSCI"
psci: PSCIv1.1 detected in firmware.
psci: Using standard PSCI v0.2 function IDs

#dmesg | grep "SMC"
psci: SMC calling Convention v1.2
SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....

#dmesg | grep "MIGRATE_INTO_TYPE"
psci: MIGRATE_INTO_TYPE not supported.

Regards,
Vivek

