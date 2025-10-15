Return-Path: <linux-pm+bounces-36195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35053BDEF23
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 16:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7307519A0298
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98CF26136D;
	Wed, 15 Oct 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="XGFCS0uM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00E25C809
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537504; cv=none; b=fNLBsPcqHh97iNffHqzb5oy3BZUiNFDA97Qx1iPXmhsEau+BQqXyt96r89neou9fhkMfBTtsiEHAcxGoupuT9r3dU99aIk0lkJXZDs34wzUPuxxWPb8HrprUtNq1eVLghhHaJQwnQTOqJSJoH01/F09mhr/WdTWx10YO9i/voVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537504; c=relaxed/simple;
	bh=/nBgtZKkxcriqJ0qWdrjRuK78+T/bVuqrcW5ucwSC+0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=f+CRujyCHPWu9fcBU0W9iS8NhC5dEf+YaO1ej5RTvQbnUfVWI3TMQLb0xOzKLvUaa5iiHbLRkf3nOmbEOg/pu2FmB7wS9HIiQf/cRM5MRiR6DJKuyBt7XkhG8mOdwMHcIzF7dEFX8cGvg8VyDdQyI3J17DajNaYZSHVtMsOdlTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=XGFCS0uM; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so8116274a91.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1760537502; x=1761142302; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pTmsMJarOdhYjpDgJ7BO+PF+hkcjk51iWlHpTcTPLYI=;
        b=XGFCS0uMBT0erHIsfAXEatPVWImzJbx3YEm9czeTnqKxrIvzlIP7ixCGUN614cfWlb
         oB045jAlLgKQrIjTZpJuAIxGtNCAPs+BjVx1MvJRv9SC4FsCQ0dVLh3r7suBWZOtRXLJ
         gcA5NWuWXiH/+aNDPUBxTEJq9n473RD0wuGqHWlgvMzHz75PJzpXkcJrS6YZIdtgZeKf
         ummKjbN8MVc7BcDOIL3VX3rXhpt0k11DhisKpxU2bWWdRHycY2WEBNgphHl3CaFHM01v
         wBuU4m/uFtCcvJmYvkQ4KvCAoE8NLb1wrI4GpPfRCkm4Sw8cLbqCGixab60GKHtRitNG
         TGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537502; x=1761142302;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTmsMJarOdhYjpDgJ7BO+PF+hkcjk51iWlHpTcTPLYI=;
        b=Wgt/Wun85/YpqmkgXf8+Jy19AbTnAIJ+yKeIsbNdv+TIeaRwr8zoprcLHDJhc3Mz9G
         H9+f9jaN5RXdDrhb6wRoQVEt64fa/OMecMZqgybzxorhCLw80A5NpZ8+mPzGsLZGQbFv
         xn+Ol0ASfaBO0wynl5pPv/mYXWix6DDkNMojpn4nYNn4Vr3e7cSuy2MkJ8FmyE3oJERX
         LEgEU9Xrx42rI8b8aqlRLYclKFCFmISAr4HNJRvbcPSTct3RaByrSOXL9dQxrchceYej
         6yd4s2HlCd4bqD3wwCqTGbUsRxOjAd9lxXjpKWwzptcOYcYT83eY9wmiAyyhGEgECe+B
         VtVg==
X-Forwarded-Encrypted: i=1; AJvYcCU/TFCtu8D4Dlv5QJQBdxXMtKp05jp1zZ4cYV0jwSSIfhC0VKBx5LwAo1EEBbLMjGDFVFuoWqvzVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVeE53lpDun7ncRVKQD7wVvb1E/WPDiUdsFRGndCQK54KwZGz8
	evtBKdfym73wedI0q4qBURi0YUAAHUdpttFzRKUKvG/XWvrYwlkKWxLvvGgkbHou4UUaDJt/G1p
	eV+fN
X-Gm-Gg: ASbGncunWPVGGHuEl++y/zhhsyAz/eTW+LaVZImz5psc1i6QsuV2EaMX5Mxq2Kt7GoO
	OszNnE9aHlw9DGbufcZXsALQPvZXvEacKTnXFgoIghh244BrIvxcq6J4hHidEiWDApVZ00y+KKO
	m1odgJ27cu7W3nY+V0wUfVT+m/Xcrna/MYkNTuwiZe/XSuU2guvY0xNs8/7MHIeGo1VRObGzr/X
	nLahxV4DPjJdIzVe2EG5cB2wry2AdXlvvnnaro54oL+rOHesza3XibkCFY1VLNZoPBDpFpCfPPK
	gaaSi0+MrAxQh8/NDM3NM9Htqh8AJ+n7zUj7qUHO4p5ju6w99azAO/pz4iz5hGUJzsLuEDn7DRD
	T2BVi6vp7bDGl0hw9iKmVeO75VaUBWKuTurzSJ76rL9NHpk0iBuMHgeVhPyUnJMTZ0V4nEW43r1
	U/5F8iPJDebz4ExMrA
X-Google-Smtp-Source: AGHT+IGb9kuRZWUH2yjd/1znZOpJ9uzg/EznGG79TKbBAx/N292/lt4+1DajykIko1N7G0fsQyxCSw==
X-Received: by 2002:a17:90b:1c8f:b0:32e:32e4:9789 with SMTP id 98e67ed59e1d1-33b51105ddbmr39449664a91.3.1760537502151;
        Wed, 15 Oct 2025 07:11:42 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9786084fsm2740093a91.10.2025.10.15.07.11.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Oct 2025 07:11:41 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Sergey Senozhatsky'" <senozhatsky@chromium.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Sasha Levin'" <sashal@kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	<linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"'Tomasz Figa'" <tfiga@chromium.org>,
	<stable@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7> <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq> <8da42386-282e-4f97-af93-4715ae206361@arm.com> <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi> <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com> <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com> <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua> <001601dc3d85$933dd540$b9b97fc0$@telus.net> <sw4p2hk4ofyyz3ncnwi3qs36yc2leailqmal5kksozodkak2ju@wfpqlwep7aid>
In-Reply-To: <sw4p2hk4ofyyz3ncnwi3qs36yc2leailqmal5kksozodkak2ju@wfpqlwep7aid>
Subject: RE: stable: commit "cpuidle: menu: Avoid discarding useful information" causes regressions
Date: Wed, 15 Oct 2025 07:11:41 -0700
Message-ID: <001601dc3ddd$a19f9850$e4dec8f0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFP8RZJEbA2uDnjQfbsE3QfwpHW3AGSQ1aYA2hH1ScDEHwS7AHjtqkUAUPNRMECUslMCgJdmtwzAg5460ECxaw7RrU2HJdQ

On 2025.10.14 21:50 Sergey Senozhatsky wrote:
> On (25/10/14 20:41), Doug Smythies wrote:
>> What thermal limiting methods are being used? Is idle injection being used? Or CPU frequency limiting or both.
>
> How do I find out?

From the turbostat data you do not appear to be using the TCC offset method. This line:

cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x0f690080 (105 C)

whereas on my test computer, using the TCC offset method, shows:

 cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x14641422 (80 C) (100 default - 20 offset)

To check if thermal is being used do:

systemctl status thermal

Example:

doug@s19:~/idle/teo/menu2$ systemctl status thermald
○ thermald.service - Thermal Daemon Service
     Loaded: loaded (/usr/lib/systemd/system/thermald.service; disabled; preset: enabled)
     Active: inactive (dead)

If something else is being used, I don't know.

... Doug



