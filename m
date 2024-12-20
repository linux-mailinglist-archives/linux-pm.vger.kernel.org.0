Return-Path: <linux-pm+bounces-19584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1259F96DB
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 17:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE271883833
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57283219A63;
	Fri, 20 Dec 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFYDjqS5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0C21C4A1C
	for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713312; cv=none; b=Ua5TfPq7kOqPnZ1UQarFC5hu3cnpluj9HL86eFfnIF5UILVS1jHiSc7tu3jmWi8g96mFbqfgufUEy/g1aUz0vNQKM10J+ceenQINgIuHZy0E30sVy+TDFe0IC1TudSOw7UomxhySaQxu02FBeYa/lLpI61+2LJHCEf46ZDcwRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713312; c=relaxed/simple;
	bh=+uqR5hchscqr6YR4+njrT8B11FtlYQSdI9WQuKB/H08=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=renfBiKEWnrnrkyJqOpErCO1D3x9O+WwA4ayMsLcYrr1asEE8RHuH4vuKrd00v4KazScuoVUQ9/PiPCTAxOX9j00SOTvkyelPsksS8YY4P/td/nD5Sw7D3ZhXmbnzRHsilTGRtT1gDg7QuKdXZl6LIjR4XeMwYs1q4T5wZyI8Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sFYDjqS5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361f796586so22987295e9.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 08:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734713309; x=1735318109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZByLX3qMcgSrvToNlDtUFTZ3GOi+oQgA3+Ql28cvCo=;
        b=sFYDjqS5yjwuXZC0K6LnAquKTx4mlHki3gdpxtIfznhV4iiAGjeN/aoGQn99pmUjkX
         s12MaNL8w/beLCKuqEVxo0tVivGK/xxrR/rLimzWH/wC+l4HZoNpuS54vhcAYOiZQU6d
         v4aT3wesdUBAxsi4dsR5qyyBowYP96NNNNU1coxkfZs3Ta9ynTT4J/omK6VeOJX5pkYE
         EftuzngZ4pcUsrlyGXK1Yr+HoVni2teec8zI/C1VqzANTIIkI7FxE/DmQhH6YurZw2xs
         pv/4Ef4mgzQjD47WjyAmUDfZqQ22C6Rvu6qENbAm2XkznkM0IgUitQLxQcRgu0g3AgxB
         xaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734713309; x=1735318109;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZByLX3qMcgSrvToNlDtUFTZ3GOi+oQgA3+Ql28cvCo=;
        b=JJL2gtEItBbPMt/b5lt9h/TR5av2v06mc3go3Uz7DJbswBkz60qvjH+BSLsBRod0qw
         xZHfHkV8eZ0NLEXyvqo9goN69o+BIt7uBBLRplKgBiMyNYGnujwDqbytC17yNX0SL4Zg
         2gl+iKlbpH/nGRcTJ01o4ZisMPLzzPDuPk7wPvrGiskuDhGNAWPqGuljSztBa4fOudPf
         kd3ak2i5IUoBdiocdW6fvwwHGd0qlpCpiS6KkdeCC603RkYdKeGYuFo2Ucv2Ec16lHby
         S5qwI9iQi+/gDIcNbWTYQKFw/kF1mcW1yW5PGPKo/EKPdKRV1esPSLdrJFoiZoix7BAq
         UjJA==
X-Forwarded-Encrypted: i=1; AJvYcCUeT2nMTfgoGSiS+rqXQk8MhPLBGZKHg/H13RSbWaGyyqaUmCdT0sJ5vDSeTiQ51/E6B7bA+9dLVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8V5Na9GPaGj+WLn8ORw9tV2bOJkITWhnHU5bBlMCsAY2fyery
	xMq6aMMg/JjLmq7PnkLN3oFsjJN5S8oj7tqSevikoNSwpStAtHtYdOYJu7ApkJ/wTII+ipzM+3V
	f
X-Gm-Gg: ASbGncuFU9foaoyroYy027YhpCVa1yhSEYTl7nX/SfyrfGmWkUzOD9DPmfs/Pu3zaIN
	GXrQSlwQ/CL+9UsZpw+MWLdovpTmEgRKmS+4ZyUegSxNZ0q8EPEmZ911ptmNQscRr+S+E9nTDX+
	Rin/47CZoG98NVyVqR1OXvYLXi4PcexmWF0MUX4IhYDZ0FIbx5VHV/3KXmC9fX2aJTJd0hkCGzw
	brQ5BICWCnMfYijN7ighIwD6jm7LMnn5SC1KCqzmzAfaDvy0v8NNoIUBzMo4YFaYsSaSAuixNE=
X-Google-Smtp-Source: AGHT+IGOyrG86B94jpBWzvLbfbP0jGB+WqeEWTMrf9WizZonuQRh7h7657Bkk0qrhilsJg0W5yZdeQ==
X-Received: by 2002:a05:600c:3b86:b0:434:f0df:9fd with SMTP id 5b1f17b1804b1-4366835c187mr33419095e9.2.1734713308965;
        Fri, 20 Dec 2024 08:48:28 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm102650455e9.0.2024.12.20.08.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:48:28 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Jennifer Berringer <jberring@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20241104152312.3813601-1-jberring@redhat.com>
References: <20241104152312.3813601-1-jberring@redhat.com>
Subject: Re: (subset) [PATCH v3 0/3] nvmem: fix out-of-bounds reboot-mode
 write
Message-Id: <173471330771.223296.13009549390429951707.b4-ty@linaro.org>
Date: Fri, 20 Dec 2024 16:48:27 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 04 Nov 2024 10:23:09 -0500, Jennifer Berringer wrote:
> These patches fix a small out-of-bounds write when using the
> nvmem-reboot-mode driver on Qualcomm SA8775P, such as by executing
> "reboot bootloader" in a shell. Relevant error log:
> 
>   BUG: KASAN: slab-out-of-bounds in nvmem_cell_prepare_write_buffer+0x144/0x47c
>   Write of size 4 at addr ffff19dd8e1a37a0 by task systemd-shutdow/1
>   Hardware name: Qualcomm SA8775P Ride (DT)
>   Call trace:
>   nvmem_cell_prepare_write_buffer
>   nvmem_cell_write
>   nvmem_reboot_mode_write
>   The buggy address is located 0 bytes inside of
>    allocated 1-byte region
> 
> [...]

Applied, thanks!

[1/3] nvmem: core: improve range check for nvmem_cell_write()
      commit: 27a3485271ed3e81dec1e51460dc671dae387a2a

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


