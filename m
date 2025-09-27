Return-Path: <linux-pm+bounces-35512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7A1BA6441
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 00:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED36D38088A
	for <lists+linux-pm@lfdr.de>; Sat, 27 Sep 2025 22:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B272236457;
	Sat, 27 Sep 2025 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRFKiv/J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB81E7C03
	for <linux-pm@vger.kernel.org>; Sat, 27 Sep 2025 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759012452; cv=none; b=c6nj/lEELuwIMmrEG7+CWj/usDjCpwwJgQJVWoWa6DfKWpFSwZFXZ0dXfpkpwQ4CsvV4gmsN8iDg84F6HtjtRZExdkyqsi7k5Zi3PotDe5C1H0CCImtBCCVpXugAov77h4OVc3XID/B/mLUWhQDPFFAO8v+kYWQUuLSLDTTztyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759012452; c=relaxed/simple;
	bh=3ykp3PJQEhX+5JnJkdMV+50B1GBtcUenqCvNZ45iXrE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sNlz+ZXRCnPeubvFp+IOz6Dv4RHTvXmuqREqY4WsEgcnBCZyJBXbFucNrcUJC1puJmS6DGls/OKBQHuG8o6TrjVDFTlqAaAFE37S0NfF10fYikPcoGUoqW59i3Rs1Ukqo4wJ8rd40ho2VH08TwwWXErPEtlIWDxzjwsxAQEDzMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CRFKiv/J; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-414f48bd5a7so1657367f8f.2
        for <linux-pm@vger.kernel.org>; Sat, 27 Sep 2025 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759012448; x=1759617248; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LP95bXIdfAP4ieU56Vps/fSmHsDIQFQq65FLLrfhp+Y=;
        b=CRFKiv/Jj0y10lZcw+xiLxUMX3M4Ww8loyqRnoSv6GjpoB6QuAnI6OnzE4TO7D3MT8
         tIm+VMXiJ2oPGj8z/IEPgrV4q0JMbqgRAT3iwpnXCpB8vtd4dalBpjAO3kXF265YC47K
         3twtJXSYNZH8xX2urTmY9rddc7bTBn9vnWv5iCTfKNzLyJ4nq8kkTQX6nHXGrLwwyfZJ
         IjqiqsMrlqh4XsoNPIqTF/OtB7SOBufR9CgiRGuXXvZoOACzKIFRvRXbUxRUYNgF6r9e
         +F8EzlbcpB0EAZHF3jjvo+lBXOXLj7LLQAea3pHjV2i3kSYuf39c4tr5MNle9mmr5R6j
         ArKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759012448; x=1759617248;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LP95bXIdfAP4ieU56Vps/fSmHsDIQFQq65FLLrfhp+Y=;
        b=taI7uJUEaJHmlYQEhwe+ppic/90LycUQ608WcOuPvoa/dabcvUR0/qjbKK/G8PQ+vG
         2CPNgoAFaIAFsckJqlarDhmMS4n9CJ4AiWOgqU0Q11QjUPah69rhp4jWndW4bjiE/h9+
         l979H7OKGbBlIAywRvGDg0KVaesJqjX5l1e42x5Di+3XMmRAzFLcTYOVH6M3oaO5oakR
         OQEjjLXeDdm4487NJ9JlFNBWwfwxbpUt8Z7Okz27VDdmGvmpJ4WwOI+ObFqP7J05xN/n
         ekVkWc+xoiLR/6JEBxaQoTs+z8BxrCVEM3FgZ3Pd7BoYZlLtQrwfzUxVTFYjgoEFVMPL
         PfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWggM2CTXGcGd7T8LVgR44FLSokgi/hcaKX3GrNfSd59O2RzXSb8UkHWdgRNBwgTNMFU3YX/5VhJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6uW02ZTcuaxh7bZ8xTNjZPzvilEaxoqujh26TbkeXVqRrjwEl
	zzOsGq7tDxXHok2iI3SHKSitW5yGoO4HwhSnh0A8ndHQZVyr2W9Fp15NLU+zRFwEeTqzyxwv3FT
	pr6qE
X-Gm-Gg: ASbGncsxpnnUuvx43mpAzrKg0MR7mkZ+/P316z7D0uHiVRqyk3WrqUXz+lVfMbNEjG6
	t8oqZEmkQ7VF1GMEwrqKJAINsG+ACV8SLU4YFhQ7s4VQqby8JxgoHM9/S/IqudrY4p/3KRBqYrQ
	FdIQG9csAf6GbQgZBRF8wnfUDz/TWb1L3CXZ5S0AplosKC8aawtVHaeDl6SnpQ51lD/EmnNSKk+
	qpV5kJ505n0Cj4rpsKAqJsh0rWUdHsBQNotw4N2IkAR2GOvf8ss5og9pHMs/qV26qjCFK6sbUyt
	kVYHHN7OdQawgun6CTHVM37Izhnzco6ogRzLzmjUTdtLSzDUxN4F5bUyNmfsbpNP+EjVmleUDN+
	gwBqiQJawCuPEaP7vg0bIaZFMDONH3eZKS4G2roOL9+fu2UGblwoqEQDBhQHI/7mc45sV4n36fF
	boyLI3kgCuhnDR
X-Google-Smtp-Source: AGHT+IEWocz3ojMq+fkp2gZ4P2lO2/bYXWtv4z7dcVb3cIz6dF2JdMUp2ihd8oeyteTrF91YJrtuQQ==
X-Received: by 2002:a5d:5cce:0:b0:414:6fe6:8fbd with SMTP id ffacd0b85a97d-4146fe69211mr5053786f8f.54.1759012448337;
        Sat, 27 Sep 2025 15:34:08 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fc5603365sm12641310f8f.37.2025.09.27.15.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 15:34:07 -0700 (PDT)
Message-ID: <40c2a6fc-8dd9-4f6c-9ebb-2f74f7d0b795@linaro.org>
Date: Sun, 28 Sep 2025 00:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
 "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal driver for v6.18-rc1 #2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

after an error reported by kbuild test, it appears a file missed when 
importing the RZ/G3E new driver which stayed locally after a conflict 
resolution. This change is on top of the previous tag. Alternatively, if 
you wish to drop the previous PR, I can emit a new PR with this 
offending change fixed, IOW this fix folded with initial patch (which 
sounds cleaner to me BTW).

The following changes since commit 79428e60897916401c9ed326f6ada4d7c7c997a3:

   dt-bindings: thermal: qcom-tsens: Document the Glymur temperature 
Sensor (2025-09-26 13:27:44 +0200)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.18-rc1-2

for you to fetch changes up to dc67521c20b701b5237ff486ae078829dc1f8fea:

   thermal/drivers/renesas/rzg3e: Fix add thermal driver for the Renesas 
RZ/G3E SoC (2025-09-28 00:19:53 +0200)

----------------------------------------------------------------
- Add missing file when importing conflicting change for the Renesas
   RZ/G3E thermal driver (Daniel Lezcano)

----------------------------------------------------------------
John Madieu (1):
       thermal/drivers/renesas/rzg3e: Fix add thermal driver for the 
Renesas RZ/G3E SoC

  drivers/thermal/renesas/rzg3e_thermal.c | 547 
++++++++++++++++++++++++++++++++
  1 file changed, 547 insertions(+)
  create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


