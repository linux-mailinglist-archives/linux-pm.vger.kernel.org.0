Return-Path: <linux-pm+bounces-39936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D5CCDE259
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 00:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9E50300A346
	for <lists+linux-pm@lfdr.de>; Thu, 25 Dec 2025 23:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3247C2BEC20;
	Thu, 25 Dec 2025 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx3GCPFJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F18238176
	for <linux-pm@vger.kernel.org>; Thu, 25 Dec 2025 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766703712; cv=none; b=uR2vJmpHOMIGcBDcaLH0KCPvqb8nfhCZKTKiYEz8Ui7q8cUrJpMTw/TYwtypZQtELTOUKoLkAJixhStIq5kpiRDstKxbM0zAtVXWtbvk3dVuJU5xlpi/WeRQAlWt1CjoRTrRm1J8bcDIdiQF/iGXY/b1aI4CuUkR9x2LkGVD/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766703712; c=relaxed/simple;
	bh=1nXVJoQSdXGgbMKh9pApq6y10cVhUvD4OxYtOcA9q/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faFUjcvpXLcKNE+bNB7eZRNp4c+90SpXvxIlGXI9C/B01xq+XhjeEV6u35iP8dhOYBi47Bu94ZKp4s7nQqLD5Rq1GHyU1wFEkE4b4/oijQd4KQsFzB3/T0h4PqZ8R6DVtSG3MHIIqdpjI8C/1tdHVGIGPv1DsFVhKFtZggFUDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx3GCPFJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-596ba05aaecso7300933e87.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Dec 2025 15:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766703707; x=1767308507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncHdqjENSZCuc/WVDnKcW2WQO5yfWiwK76OS/LmTBGY=;
        b=Sx3GCPFJDHNY/A7WjwxwL9YpPDZiWCj+fkIUE37svktNgtHvqynBLiI55JmRpM6jjW
         ykhjqI7RXVpj9/jZAwL+wClIHdL9z9gp4ETS+Oz23I2Bf11dHMMyrCUR2uRZGUSeiBnr
         sBDjdIczIzVhbZeE4Ij79io51IqpqfCox0qk4cAqoFXKKGhlBYMdPLXVthsM2zhGkoSG
         F2NNOAf1+OZaHW0QEFgQGw+6XwUN2Nf2up/QAN3/qrrsnACekHewIpXGSYOuUirCZZRv
         +HPEixa+WUhe7IAa/KmuYibxTyL5rcvnPWD8xziEu2k+9qKiP7Xx6cj3wFnq3BkWK8Du
         x/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766703707; x=1767308507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ncHdqjENSZCuc/WVDnKcW2WQO5yfWiwK76OS/LmTBGY=;
        b=ro0MQwlCZ73+bccyViLlDh8cUN7XXUMQPzihZxj1Fr9LJkUmnItTqNzlOKMn70xwvu
         7jsUkV2Y/6gFPfe97bnfsfbeZKzNKL7h5nxYRBAXRKoBUq905N+bUi/LT34ftRI+v6AF
         kZ+ma7WHeOylqzpNVgFkZ42mCRRF9j8QV/oZDrYKjDlBV0Zl5pMmS8a8vspAZrySo6QL
         RDL6QdRNKSAyG9rZ1WgJyp2BUnbGWuN67eGOlsa1cSMbhQTlLmVofNxeVtPgYDdC/cpc
         EuxZyXGzoL4KzZi3J5H193gMFvW2hPcvv/n9f0774qU2g9mlB6I9gWTpLksR9PW4yiai
         4aNA==
X-Forwarded-Encrypted: i=1; AJvYcCX++D59wb1o4NaFm0ZbKTZICyJlRNHBt21SVwRoyv5zxmIn8CMMZAI0zahkywKVPj+SaSOX3gURpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KIA0euMcoROH1lVHjlXa+vGubEMR0pGBE8yQnqS1oooQSYar
	J77zBgOF3zXUAGNAjGVE7TYI+mmIcT+8Ou7pySFXItthYEwOtNbblOgn
X-Gm-Gg: AY/fxX4iPCcZPIV2qLgMVb8YO+fcvfSMmfLS3HZR5cP1yVI1Si5oWbyQhv+728JOpzx
	g4SOfoNpWA6gcW4D1RbUxMVbLs0Wnoq/CudRZK2+E+oIZS8mhsI1IhbNd3Ro0sjcihHN3xB+/Tc
	PQnv6m4+pTY+AaUouYUNFBgFnF9Bd8kAZWvFyRQVC6vt/GKSRjRqUulxuUUwVJ+HpjEef7NYNNB
	KR1CkK+XNG54TxADEP4y/XLOU8HGMkkXmYoQu3RcsuOTKo/nOy8RSvDu4nsLggpLhG56GfTprOi
	XhecXHFIodL9Rcfz+P/2tfj8XIECEmb1nRrP3Lcir6NIfisRu3XHGMmuVmGirV5+u+cniAvYEvp
	74t/rp48hOJwxKQ5u+aY2ojiQk9R5guNy5VhfxnDw8ZaRpU2wttTPGKM7j5an7j45wMU74w9oCu
	RTUGB7rd6f
X-Google-Smtp-Source: AGHT+IFNGb1M3X9NAk8pG0TWDgEZk3PtPJ6uu+jwzwArZcBrnR9KLLHpjsWJe6q+HecZnTMtk8Thqw==
X-Received: by 2002:a05:6512:4017:b0:595:7b90:4098 with SMTP id 2adb3069b0e04-59a17d1e552mr8076867e87.19.1766703707267;
        Thu, 25 Dec 2025 15:01:47 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59a1862836esm6223067e87.98.2025.12.25.15.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 15:01:45 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: mario.limonciello@amd.com
Cc: Dell.Client.Kernel@dell.com,
	andriy.shevchenko@linux.intel.com,
	chetan.kumar@mediatek.com,
	chris.feng@mediatek.com,
	hua.yang@mediatek.com,
	len.brown@intel.com,
	liang.lu@mediatek.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@ucw.cz,
	rafael@kernel.org,
	regressions@lists.linux.dev,
	stable@kernel.org,
	ting.wang@mediatek.com
Subject: Re: [REGRESSION][BISECTED] "Wakeup event detected during hibernation" on Dell Precision 7780 (was "[PATCH v4] PM: hibernate: Avoid missing wakeup events during hibernation")
Date: Fri, 26 Dec 2025 02:01:42 +0300
Message-ID: <20251225230142.2403756-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d06be6c6-f5b7-4259-b76a-20dc52a5ffd3@amd.com>
References: <d06be6c6-f5b7-4259-b76a-20dc52a5ffd3@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mario Limonciello <mario.limonciello@amd.com>:
> Can you try using command line instead in case it's actually the 
> touchpad click still being registered?

Hi. I found another hibernation bug and I want to fix it first,
because I know how to fix it:

https://lore.kernel.org/all/20251221063214.3276685-1-safinaskar@gmail.com/

But I need help to proceed writing patch.

-- 
Askar Safin

