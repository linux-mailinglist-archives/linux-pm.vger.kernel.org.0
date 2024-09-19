Return-Path: <linux-pm+bounces-14500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C45197CE99
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 22:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF37C1C21B1B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 20:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4623142E86;
	Thu, 19 Sep 2024 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="XNXz1/XC"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7500A381B8;
	Thu, 19 Sep 2024 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779294; cv=none; b=CsgZTXSkRWcrAJEU2RWLBkqVBupCsqvDEbtoKv1Q9IqvB76pM9ieLV1HVZ5qgviIPQDiDlbs3JQsE8G5kySci1kZc5IwHnZt9EGzNL08WHOhcHkQS7NkLtpaTjRqekPAqHbnYrS4AyOkiq4IOTVB3hO9OuVHHPOfCNuzhTCMR7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779294; c=relaxed/simple;
	bh=whjML2HQEMXsisGA6Qy4aqliw8AIXIgEJX9dGh1kfpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPlsWX4QQ/q9AkPb1VcljfXQpGhKW15QvcpuKd2tjR3UOExM9jRbc06MB7aQw42NyoCtehIdQ0oCdJP+FKWf039I3EwHTG6f/HTrHQlnOSaqRwSUmoCg/Ug9IJpkM7MHkOz4oKkRg5my+YgoyW2S88+Htd/WAC1N1wt53NbvXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=XNXz1/XC; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 5BB662E099AE;
	Thu, 19 Sep 2024 23:54:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1726779288;
	bh=whjML2HQEMXsisGA6Qy4aqliw8AIXIgEJX9dGh1kfpg=;
	h=Received:From:Subject:To;
	b=XNXz1/XCyAmSiZukViQhythqqWiytgN7sGyfpM0Zn21cZkc1UnHekvLRxJklwBzb7
	 gXgQAEFgx1/ZOTlHSft8gw5Vc/ugE11dt5zFOpxnOOGYAnTogSn1GfJiF06kzGK/i2
	 f2LhB8SVKt0rIO3tyxWWyCRtqmWY+Qq/aUsrMthw=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2f77fe7ccc4so13954601fa.2;
        Thu, 19 Sep 2024 13:54:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW/+sfTgbqeAXpcBk5ZUAH2bh5b+2iTzdszCpdEkBbcCEYoPg0M9tVEPmNnux089iy2qgooRu41GwHrnx+y3UoIU4+c@vger.kernel.org
X-Gm-Message-State: AOJu0YwinGhF7elXxyy4nTRPKfnqn42RFbxMhvoIVrVxA+5S88vUHwDy
	X9fV86gGnV59dnN6A0x0DVxFasqlrmiDnLAPrx3VQoOyCvBeXixr/SAxIQlu7Vp83MqpbDPzzgf
	ij4uZo7Ho7lkuX7AqlfQf8i0Og10=
X-Google-Smtp-Source: 
 AGHT+IHOS6a1Y9qovaeQ2eVjZO8WKc56Ai9SSO9rwiKivHMgSs2st3d8Ce3lWAVGVCP0G/dGhhzulhiwaOl619n5swE=
X-Received: by 2002:a2e:9610:0:b0:2f7:4c9d:7a8a with SMTP id
 38308e7fff4ca-2f7cb3394a2mr4236031fa.32.1726779287717; Thu, 19 Sep 2024
 13:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919171952.403745-1-lkml@antheas.dev>
 <20240919171952.403745-4-lkml@antheas.dev>
 <7c604018-59a3-4b70-83d1-06f0ed858b73@amd.com>
 <CAGwozwGSVAExH_9zCCKreC88J0FRU4ZM3RkBk==HvRwCUuuqLw@mail.gmail.com>
 <25b14b4f-96b7-453c-b876-6a46c4f3789c@amd.com>
In-Reply-To: <25b14b4f-96b7-453c-b876-6a46c4f3789c@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 19 Sep 2024 22:54:36 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHmd8yHzjbutOd4T39h5CZRh2rOWYH4V4AnLN+RXrRRnQ@mail.gmail.com>
Message-ID: 
 <CAGwozwHmd8yHzjbutOd4T39h5CZRh2rOWYH4V4AnLN+RXrRRnQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] acpi/x86: s2idle: call screen on and off as part
 of callbacks
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	luke@ljones.dev, me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172677928871.28848.1084488287163590011@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

I will try to merge all the suggestions and make a V2 on Saturday then.

Antheas

