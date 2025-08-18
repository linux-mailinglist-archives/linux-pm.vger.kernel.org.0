Return-Path: <linux-pm+bounces-32530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B07BB29F9E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 12:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D951317C5B0
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E2B2765F6;
	Mon, 18 Aug 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EwIW1kBT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25C258ED3
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514260; cv=none; b=gNeBuRcqfXkiSLubDK4fk7PPG0G7k5nf8RZPGH4aJl5KlHt9L0WLeYbZF/bcj8CDNWrnUnTyGjkGNg/ARTvJoB8zl7REqfWajZ62UNjrj9N+GoU62/5pXSHqgpqrsRR4af11A8aA0v1Mt7+nTXQHXP5ez0Hp28D6ROsBejfX8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514260; c=relaxed/simple;
	bh=pZ28X6C6V+lht1om+EThDAP4EVsl4TPoXoYx+3BdCx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmvPWdEW/tG2fsavRj6QCjMJgseszdj77brKxdhBhrbEKQI1Ldz4+BJ/GriZ9m0TJlFDEN7BQBiWYzJas+dPm0ce2hFDBuJN2xYkXp8Jm1jt7d8MdEJA/EyxzjRSRxRocFy0VShRPrYHfZwpQGW59AHOkWpoo6nVVYvGJQy1tzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EwIW1kBT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9d41baedeso2089268f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755514257; x=1756119057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OZHyg61EBWZaARHc87dfxpWntWm0nMzTS3sgcvk3T3M=;
        b=EwIW1kBTgag/lEv67UZSyFSE4hfrKqNCrDD5WDwgejKDJwbDaezHDvk7oo1PWAxsiz
         UUGQb3rVYbEsYNIXxOdoasaBjzLKNVZAOlG4CsiYX2jeBaHhnrAgMr4F9KXmJ6cSzSMd
         NTc0eC9azuQ78FE/3/hl8zc34YjJ3QI9BY8uGFIhenMZ78fbuf4O4bkG0UVT/RAqHaSL
         FTMLFdoObpmwAqhV7DTJzI1xIOFmFwKtEqRGy70SsAPutmQvljcBN8IXYreqAMWarj07
         QA4JICXqLYKt1ar64zaJ1APpaeI/39kh1C64dcG0Z9zZZ96hg57XjIhdNryYPWMzV/3H
         opZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514257; x=1756119057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZHyg61EBWZaARHc87dfxpWntWm0nMzTS3sgcvk3T3M=;
        b=wTOFoUV6xEOjWuaqyp/n9MgRHfQPGcu2UMvV5biM2qrkyqWyjfD8MlcEpfMGC9uX4h
         v2tjiQr8X1MLoxoA8INsL/ftklIhCpur+wtaiG9yzFysq+L7d7xdVeDuhLD51Ik236pG
         a9ky/pr/jGK9m2V/T3hfZob9ih38WBqZnh0tBS9IlJZEoCDsVhJb9gYtMlB9aOohgn33
         Gu/KKDKEWWevJ52uwFf7ao4uxgg8xLTr9rJjnirQ9+/9u4VtvVKfMGYjYhENzFNEPBFw
         WWFL7NOCJhitmHnhw6SxA5nUfVd7D5Lm2x0LkDYopGSiWKuyCp0yf5x9NJha1to3V3pu
         g6LA==
X-Forwarded-Encrypted: i=1; AJvYcCUJYAWr8DaRZjt316MhqW3KC+32STV8D4fd18xYQDfkJboHZX2ZhAHl07H/Kq3BcTJH6LefvUl+2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoB2hUNpFKWUhYAbVUgncLYNQ0V8wSjAEogNGeORvQTI8y8yLr
	QgPli0bOhd780M7AUCv8FYAI+tvEhrj09VndH0P1sB5GBskL8VCKx+oRLTqeuWjJCaA=
X-Gm-Gg: ASbGncsmnW/iOTs3tzSL06v8UdP1Em61LHO4gnYG70XFW/bVK4NpsYnuZ/lDRONVCYE
	CakL5u78oom9/U+TEYlLM3sIjF10RSSomOI1K5ARFhOMTgXw7BJdzlrzZuGq5tq/UVimJBh5MKZ
	1WSHoZDXfy5YM3QGGDr8gQMT0rVaoncHQyZLnyS+X0605NanZibxD0FeyRXftmTpUH20tYPwQyF
	Me0hpqnEXwWaHFuShzXv+aycNeUHGl86PWLyNcwhOLRN5z2LaOaCEoFp6MkO4CDQdZ68kuEzmsF
	kNILTRGj39bvXhe34Y/wfgSuDQdTZ5YWwWZl/F0emq0FXfGDQ2tVs0avmsY/XZIKYS3WJuyCBgl
	4a11vjdABmwy2KojWG6+bXd8murvgY4iJhMdt4AJzVvYqsQ4NvpVkwdEPKA+DDXc=
X-Google-Smtp-Source: AGHT+IFtjih4o8NS4VHkcYD2Txcwmf+pFe1QNvS0DpqHsE8KLRkcgWRFJ+48VhP74+JNXQyo/iL/1w==
X-Received: by 2002:a5d:5f49:0:b0:3a4:ee40:715c with SMTP id ffacd0b85a97d-3bb66a3baa4mr9592468f8f.14.1755514257365;
        Mon, 18 Aug 2025 03:50:57 -0700 (PDT)
Received: from ?IPV6:2001:a61:134f:2b01:faa4:fc57:140d:45b? ([2001:a61:134f:2b01:faa4:fc57:140d:45b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6816ef48sm12090391f8f.58.2025.08.18.03.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 03:50:56 -0700 (PDT)
Message-ID: <a1cf393a-9901-469b-90f4-81211f2e1b9b@suse.com>
Date: Mon, 18 Aug 2025 12:50:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/11] USB: Pass PMSG_POWEROFF event to
 suspend_common() for poweroff with S4 flow
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 Eric Naim <dnaim@cachyos.org>
References: <20250818020101.3619237-1-superm1@kernel.org>
 <20250818020101.3619237-5-superm1@kernel.org>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250818020101.3619237-5-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 04:00, Mario Limonciello (AMD) wrote:
> If powering off the system with the S4 flow USB wakeup sources should
> be ignored. Add a new callback hcd_pci_poweroff() which will differentiate
> whether target state is S5 and pass PMSG_POWEROFF as the message so that
> suspend_common() will avoid doing wakeups.

Hi,

how will Wake-On-LAN work with this change?

	Regards
		Oliver


