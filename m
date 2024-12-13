Return-Path: <linux-pm+bounces-19200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EF39F11BA
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 17:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB922822F0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F31E3765;
	Fri, 13 Dec 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3VKsz5b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF915098F;
	Fri, 13 Dec 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105842; cv=none; b=ZrOqRY04HoiHDeXFUM573HRd9D2mXQJF4zo24UbfyGG6n7ha6WMEflg0qJ0Dhg+tt+baaeiBe6C5N72RZR1A2FeWZHz+87DaYrbK5FDkSGKjUQCvoCdq1PGHtccoH1OOrUIZU0dc4MRjmlSJAIT1eOc7OhK3O2Oizlkl4HpwQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105842; c=relaxed/simple;
	bh=tWu4Le/UEszUkikfuTPw3UilP2yefN9WiatCnmqPaTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ulelo5wJWF5v2ZF6R/dP+c68VbAjHwFFgxUmJvoisGyaNs3qV+eqW4MOFlaXMLYeiQc30hM4YsiBuUf0Np3tGcdPkPgpIswUJ/dl/AY5XRDzlztkzpsrSxQgK7Ht54oNsF+Q1ApuyjXusbFfTL2KitGjwai63RHEALT66AprTaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3VKsz5b; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a81324bbdcso14120825ab.1;
        Fri, 13 Dec 2024 08:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734105840; x=1734710640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MyhE6p4xaQ3O2A7awygF6dZuTWlyJtp/nrxGTLFcJo=;
        b=G3VKsz5bm+37qNusNMhsnQgc9XSR5qVt1toYZXRUhCkxiFwFty7GoZpJYp8KyeHqtK
         MsdDA3wiUwwdYfHS2QsV9SrujQwZES3reKEjIy8JjtUwAMAKwviYp8YnkmA7j18nQdzR
         IDqL/kF3um9rgjF1YNS2mnsuGUheO+BuV8GzydRVdvRv/dkhvR9wfE4aXFt2/PoPdGNM
         q+Le6DoXiyS7azf1ALp5op/dUMuybRT1XGTlOcWHoEgeiHIqRvpeg1nKVUu3rIWIMb2V
         U96NgHjQvQYbrdvkRC4KOh0mpiDX2u0lHclfoUF0QT3pNl7hi1BwQByBHUQ0R/PIbNsv
         rJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105840; x=1734710640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MyhE6p4xaQ3O2A7awygF6dZuTWlyJtp/nrxGTLFcJo=;
        b=PEeDPBzSmiX9CBCa1jsKPGCqlPM2I/GN6yKO3Tz0URJL9Dhfo4dWUVevqiI68B2JKa
         Gsp/+eq8noEQbXdp0h75VCk0b4S7uoisvYMGzNt3ef3PFxI2h46Z8XSlRRC9QHEe072o
         LbHCm42B+45JVLKFD9QMS2u3lVlEc5fZH3vt0Cd/U6lfz9s/E5FT0po2Y624upxbZ7xD
         JlEufBsceee66qG8SSCPaAw9Bh5Ss4FLKZjuPDpR5ykDpnQ2JxpbGllXNZROMiiaiYoA
         YRLSyJ8I1HekRo4Dd9y0KeOkHCDoHpMJfFS2iwJ5eZdiLv/6zcDUrFiYAxEHOFNt8wRJ
         u6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtMUdnMWxGtZeV45YVc3gxkil+xY4uvgIU3c//J8bZillftRgSFiklfX75bti2CyaHSlsOnwKpQV8=@vger.kernel.org, AJvYcCXBs8nbRT/sGDZ648JP8lDFvr1495lkKcTHv+l8nD7VngkqEMYU2jbHFz1Sh5CH2yQMCx6ln4fVYabiTk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8lrzt59VeAD0htvI0DWnla2dcJ3jpzOJo7PEs2SR2nQA0NMOd
	a/aKW0Efzr0qvXwY+n7hIHiSJKUry2ihpYyXW7KVq50eRAjSCqDr
X-Gm-Gg: ASbGncuNIIMWniaTnkf5mWdM+KFSq4iDNzUJAG4/GYF/SLOtF2mYWrNCdE8VoGfJZrk
	QSIXjZIOFSYsJbFj26m3GzigUvsN+GBANA00i1P1XvDsUf6bfuiRslBCbLfWew8plnk7EPl3UY0
	OTcr5T9l3ZMrBV9kdChdOXV5aUvbNbQ0NxBPjcEVR8MtYnKhisiZ35IdcmtsfgN4Sowlf1x+/pH
	/HLRbhtbK2PcUvd2TTQtgo3+7wPfDBGMISDYfJGBFreWk2fA8Sr3qZfzD73BM/fjMkc4KvdgFli
	v7ABI3cWKgXS81pwqK/FFx6+esg=
X-Google-Smtp-Source: AGHT+IEszlQXuqrkPYsX/HEMys/ZHxP36z40t4z9cG7j/MZLWhxTBqgX7gBXJMpgbC3JI27DgkLtcQ==
X-Received: by 2002:a05:6e02:1a07:b0:3a7:1f72:ad3c with SMTP id e9e14a558f8ab-3aff0961e22mr37626355ab.19.1734105840042;
        Fri, 13 Dec 2024 08:04:00 -0800 (PST)
Received: from localhost.localdomain (65-128-205-244.mpls.qwest.net. [65.128.205.244])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a817f6e099sm40130415ab.23.2024.12.13.08.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 08:03:58 -0800 (PST)
From: Shimrra Shai <shimrrashai@gmail.com>
To: shimrrashai@gmail.com
Cc: krzk@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: Re: Re: Re: [PATCH v1 2/2] [Draft] dt-bindings: arm: rockchip: Add Firefly ITX-3588J board
Date: Fri, 13 Dec 2024 10:03:37 -0600
Message-ID: <20241213160337.5561-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213154114.5078-1-shimrrashai@gmail.com>
References: <20241213154114.5078-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2024-12-13, Shimrra Shai wrote:
> As you said that is necessary "for automated tools to work"

Correction to make an exact quotation: I meant to refer to when you said
"so this won't be tested by automated tooling".

     Shimrra

