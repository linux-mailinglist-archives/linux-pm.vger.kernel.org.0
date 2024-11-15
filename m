Return-Path: <linux-pm+bounces-17592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1589CD605
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 04:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C30C1F223AF
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 03:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CAD156F3C;
	Fri, 15 Nov 2024 03:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNp6h0mM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833FA42ABD
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 03:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731642959; cv=none; b=nqh4uffEq3ftM+pOeSv0ASrA52+TJ60/dJ0yveRMX8CZb+ROMHGNf7joJKv+8/zXiN/e6hkPyufD4QPeEn6qW7Sm8WxejOn6v2ns9UcP8pF4/NN+LvEyFUneVXpXE/f6vJ907obxk4rvRF2NutIVq0cZoD1N7Tu8Oud3CWrP/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731642959; c=relaxed/simple;
	bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=uhkFoD3HN121Flce8RNHjEkMJgzRaaZsZYDglGoXILwCMHB5RDdbcYCs0xTTT66aDaldLwbgfHS5yHH+B0AT06nxPNq2z3VV/C8dRcYxUordy+ycBDl9yrSY+shbv5pSn74UovMgUzOGWXiux5sbKNAGxxuDQNIcZQmydDK+GOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNp6h0mM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315eac969aso7632065e9.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 19:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731642955; x=1732247755; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=CNp6h0mMR02acMhPupfUX5wqjRpRIj2SMp1xWfnM9+kJtSAHAee8hy95LXBr8TF8HU
         +Dg8QqJlkecA1g8siuDuzSbMpzl2ApTRB3o80Pi+Dxb5cjBjbgOxYVVcWvfn9TOJiW8B
         JoZ1s8z5zC461aspVYq6dDfncqBkjDYZH3m8t76llAYX+EO9OOCVqOMk+LwWKJAcM1hc
         uRzL3LWWgsr17PhFJ/k+iLhdOZkmnshyg0ZgvUMhpiZIx78qz4dmb+r1YNHI7os8GuII
         WBUKfIBB9Mzd3wYlSA2kC1ssputhbJz2rKrhi2qRKCLytlFAyht1vH6n+MWK8jFFKHe7
         8d+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731642955; x=1732247755;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=WTqtxXUQXct4pRdLeMV0aMvWLgk0WbHrCfLlQE3giS0Yhh8ylNbF106ArFnusrBrVl
         f+RMeZFSAL+/HUBbn+T3Jki3n7a6fUNIr4d193+npdoaX8ylMXdSn1h5r0rpIWQ14vn3
         Es0DMC8fq2TNuzY2q7AZitANsWRxrm84xmaHtSdZbTiVbvR2m1iZdzeMeid9t5mAHeSc
         yIFZy4BVS+3RLgqjnj27iB4WDxOi/Rm3Y88HuYzKqLnf73uy81dPgo1C6LqEncvvkBnW
         g8R1kzXupd8CwG7/iFRi9kmmPBA9f/Emzh7l8VPzErghstLEnbb+dQ8W28tzNjQgz/uS
         8UpA==
X-Gm-Message-State: AOJu0YxV+/sB4vDoT2Vd7MSg46BQsLMgY1WFlvdMv172N47ToqVDlkxL
	cGTLegNGwZEvpkJpcLw1Jc8uRtWWI+HXcN/qYmAStSWMD/FdrO3bBzhkwg==
X-Google-Smtp-Source: AGHT+IFM74eOK6dWhmoW40i3B9OW0mCL5e7mJef6wkpFP+vnKzDzb/ZifJ9iBCDaMin96I85d7bVRw==
X-Received: by 2002:a05:600c:3ac5:b0:42c:b8c9:16c8 with SMTP id 5b1f17b1804b1-432df0184f2mr9209765e9.10.1731642955113;
        Thu, 14 Nov 2024 19:55:55 -0800 (PST)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac21b24sm39473505e9.40.2024.11.14.19.55.54
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 19:55:54 -0800 (PST)
From: William Cheung <rahulsarkar7433@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <4edb3f53a9ca509da576c47bf76326183908eccca1ea79a6f79f1d477e55466e@mx.google.com>
Reply-To: willchg@hotmail.com
To: linux-pm@vger.kernel.org
Subject: Lucrative Proposal
Date: Thu, 14 Nov 2024 19:55:51 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

I have a lucratuve proposal for you, reply for more info.

