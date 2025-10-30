Return-Path: <linux-pm+bounces-37062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD2EC1CC98
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 19:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CE21882390
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 18:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B46D3563C7;
	Wed, 29 Oct 2025 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoorhfRj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F5320A0F
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762867; cv=none; b=TaJUsxhTXKI9kfW7Ue5BFo0HrSVWQ03HKj8U8h+fvxr/umd2M+Kg9w1nFqfugzoK7UtokIdbuw5Er8Fsj4AmieyybwWR1ytjfjkwig6Vt8MqtwQGkm8N1W5vnIPngzzT8q5zgrKMvoFUYAY9J/UTkDtWkmLHP9fhr1PU8iEn064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762867; c=relaxed/simple;
	bh=CTWegixHFEa5eJOgjs271DCyYwGiTYFeBEQBky5Cs5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyWXta5wL5qNs2F+dbBVmMHgINvOchhInRREdvjKi/Dv7W/6XdGJhYqqlVazcRIUrhuZ6r1hNFOYBt9TKJquA9U9qMO505QOEQDQcb/6mUk0fM0i+ungz7fFTfFujOKvvnXQ/HXoqhglrRheoIBfdgjRgphYUJ9tmWJ+5+BomrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoorhfRj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290deb0e643so1125115ad.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 11:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761762865; x=1762367665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ogeoHQ0O1BVIxTR+8ZrFN7NDholX1XeAgqEssh3smo=;
        b=aoorhfRjrfo2xVbmWP4+R92Lxv95ViIUjXT3CnDE5dyVRwihzvRpHjnIcrgIbrd25k
         0T7TRRZI1C2anRVGtQlWcjw5R2ejT5ZlzUd0VsPfIMA6bsIx3p10o9j3JuSLPuW3dIKJ
         zUTVWKt49kLDmLvB8ria0EZ96iBe0e6UJMGchL+pUVs4tWY8RWUIowRxv+W7v5+h/2NC
         JnCVBfkqDr6WGpJ1m1bfCzsD+fqvf+yWsUwCst9FL2jGZhONCTi/0qIIOaMys9vgS3fa
         wBZNwbl8HM2m5GNeVoimc14BwmmUiqsgTXfeGfG4xaptRUXLHvbXRLCMjU2EqezrfmXa
         crDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761762865; x=1762367665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ogeoHQ0O1BVIxTR+8ZrFN7NDholX1XeAgqEssh3smo=;
        b=Wo7YlSrMUS+5iItn6F4Oc5lElTgcvjRD/UYJMF1Du2KYNp6Exo3V/HsKuEJHTiCvAy
         8wJ8+Jl9o10gDBpox8o4crYZSD/FCanBfydC7bNmBR8q/DHumQgNSOJ1htAySG7iPapY
         PhrDoPdfkiyrMNj3mHe9yPb7KbUJCmfsvyX2YX1LBL2vr4qLkcodiKDOV2VjyZGfqTTx
         v7Og701OIi+M8goRbjBOw0B/IDjhD7VHbRmfLG/9FIZ8/FoM5bVzqH5W9Dn6GcMQ+4EJ
         1kpKlLNiLKmqh4sqqdXzjaYJ7aWYt8SeOJfgJwFMooCsjcktS3suLLrPcdw0XA1d/iqt
         gqUA==
X-Forwarded-Encrypted: i=1; AJvYcCVT/nwTk2J85Z63yC+phvwdugMT6O6SLp2LEzGEZ4D+o37/vPELY7Y70LLjAAeZNDXUN8xawaoMAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMSH0TTJnK+GBC9OHxG1XGI7lk/3+SWtlmirVn/YBHfpuBkmzF
	/ZqLlPCAZaPD2VbTTgMzPyJX0DEEh8UOKVJN+MJng9XtBgigSeP9MvGw
X-Gm-Gg: ASbGncu+gTHANA3QOwwd0wWgO78RDURYllsQnKncvwxPnS3am+3Ac+CYlUHy8Pa9djR
	HRUw7fRxH4xEU5/hOnDFX/XfI3WWNDa9qUR6BC5hozXed1PcY6SltpIAM4NqZNycji4pYtsvW1m
	E2I9Pc+6BZM3C3iX85UsIYEF5iRF0IKAJzAbX949EKztQZ+yKcgOvFyW8HOzGgslWcbfqN5PXPj
	eZymYR39Ui7Yp/JUQNKbzEkgrwuohwCSo3T7/qgTUHCek7FKyCKEpyyHXdIFd5HK9FFntFPsJKi
	/ZiaW80OO5ZrI8uxXhRzSMt5sdaI2uRLZVsjD0t+ZIwRFHed6Dhk17b9O/KoJkwU9+eoyzUxZ77
	V8ENbEtgur9zQqbE1uUn6Pw50cAC9tE8TlKvJR9zEeSUaj6iq/pK1Gc02g8kfkwDH3C8Tn1Pe8C
	T3w+QAUpY=
X-Google-Smtp-Source: AGHT+IEEht2FlqLLG0Ynfa5FSTjLG86LfIAz4K2RirDJOlW5Gbt1L9iZ3dBFembId9gkTaOOHsrmdA==
X-Received: by 2002:a17:902:d512:b0:294:ccc6:cd2c with SMTP id d9443c01a7336-294dee491f3mr44845335ad.22.1761762865379;
        Wed, 29 Oct 2025 11:34:25 -0700 (PDT)
Received: from LilGuy ([2409:40c2:1057:4837:724a:2122:38a7:2755])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e42afdsm156921855ad.99.2025.10.29.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:34:24 -0700 (PDT)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: bagasdotme@gmail.com
Cc: corbet@lwn.net,
	david.hunter.linux@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	skhan@linuxfoundation.org,
	swarajgaikwad1925@gmail.com,
	viresh.kumar@linaro.org
Subject: Re: [PATCH] Documentation: pm: fix duplicate hyperlink target errors
Date: Thu, 30 Oct 2025 00:04:08 +0000
Message-ID: <20251030000408.44745-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <aQHyhU78m-9RPQ8q@archie.me>
References: <aQHyhU78m-9RPQ8q@archie.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bagas,

Thanks for reviewing!

Here are the versions from my environment where the warnings appear:

  sphinx-build 8.2.3
  Docutils 0.22.2, Python 3.13.7, on linux)

So it seems the issue shows up with docutils 0.22.2 but not with 0.21.2.

Thanks again for confirming the diff looks good!

Best regards,
Swaraj


