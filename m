Return-Path: <linux-pm+bounces-28355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CFCAD3365
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324E6164A2B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ED628C2AD;
	Tue, 10 Jun 2025 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMM1aMQJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66C21FF55;
	Tue, 10 Jun 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749550613; cv=none; b=pXmDTOdYn//NHlgBzIjVepMw4A68wz6jwxP5L6/Iuds+49CHEFy9DohrTLxBOskXx68hiKCIgKkh/KKOTxY7s1c39TMr0N3qmuWFM6DY1QueJL0dKi1ACma6MFqrk2E1VGgZOqL9zN9I/rIduhb58f/HRr+ydQj+Ta6m9OGIpGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749550613; c=relaxed/simple;
	bh=UUKpD09dHui4C4fVtz7ec5/TcctLfFsmGhQ+qO4+hGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z73UuCcxPELKRr6ABDxa8wI3wsgvjMmokPxEjnjHlT4W/FlpULCzXZZ1WYFvZ7D8O+duWu0gBUTmOiFWU5c49S7w1CZqDwHtRGCDX0HSMLFKgjC7BpwBrwngOJ5QPzo1RFmS48Yc5xbeNzsZu9GO5fE5vUvQaoyQHDEpNMGInLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMM1aMQJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235db423abdso6412725ad.1;
        Tue, 10 Jun 2025 03:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749550611; x=1750155411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUKpD09dHui4C4fVtz7ec5/TcctLfFsmGhQ+qO4+hGE=;
        b=QMM1aMQJtT2uTs3UxjQSmmheeralkBoUCTuGiaFuLO9HKTy+OcSkGtBpNUE96gawwe
         1dOchvLFlPvOIZWQSnU1BwGWjwdzWSRULmBmvGosYRxfwSg0tD55bJiqV2Wk9bcfdrt2
         W2inQr9ZYjmXEkcENyTGtcKuXkco/iQ2a9G/c8Cb94obBYsv5yCf3njL6pa3G4xOkRbG
         pPlp1iW+9FVp78QPBqzVFT4kKCO+bF8zJyeqMV4FsKM+ABv0FyKy+As22dsua95+oUG+
         iJweeRMedV5fB7adC4iTMeFrWdTM9kqQB+RPuOZC/fO1iju4Ze8W36yUdP5TnQ9pg6OM
         lu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749550611; x=1750155411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUKpD09dHui4C4fVtz7ec5/TcctLfFsmGhQ+qO4+hGE=;
        b=mEDV3aDMh4B/u5mHCb92EKP1xfaxu+eM6n/pJMBNjNT9UkvrS2rSNtvOKxgDyL9K6q
         A2yL0VLVCDmVcKO2WMWFvPqzeR3KA6uzZEDVqm1SpgAixSKitY1j4HAbgBG3G1Iw9aQg
         Gp5YQqURVD1TEValdko9k/4ktue4WfF1fzPIuhNv/RLCBBPnHCwsfWi7zN5aFXUaL3bS
         Jn/pVOKBUAEn+aKrXCdBSoTgxJARpo+qaRXPDXgJyP/WzK8KgvhWGWx+1sYy3K54oDW3
         zNoV9vN+IvwUjglWOU+WlN4c/BIfFkVRyoOu5lA+EYRghli5FwsasX3kpJHyitOIw+hQ
         41nw==
X-Forwarded-Encrypted: i=1; AJvYcCU0LVxo3pYypuCO2UDqkqsA6j+nIht0Pa2vZkiHDP56FRAT3nA8dVRlSPYtKrTYYhwqt+ILfL2lgQRRRRAtb8g=@vger.kernel.org, AJvYcCWxXUKBzRFjZ/KcJnNYDaw35f1AiOj//kFm0eSgkBSLKpJwmDM8i/Jawj9M0OzuyKuoy/8VRoD4S+tGv5o=@vger.kernel.org, AJvYcCXi6P932JAhd/atAJFNKTOt/sTOPcF/chUVanWyDkXUzUXiyx79/sq4J81mAk3dKgNcSO1dXM71qrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIg3LwXkYjbOF7uRY+bh978WObK9nQGXUJLMu/HneuZvHsEuc/
	GG7G8qOb5pHY/wGn5pATNQEBkJ6nEf4FXDtmiFwsQP+pomFcOTv2WH1mJph+zgbyLP0i4WY+eF9
	kcrbLhPgaqLJXTmVNdwI9Xsdo+rnaQrw=
X-Gm-Gg: ASbGnctrC0oI5sjWBqoNkM/AXYhk4DR8civuJOOUtb4fcj3BrTm/iY2dKTiGcs/lSNw
	9J6iKsIRW1GUZj77es81UkaSgxExNRlngkvk9aKjUQ+rYJHjaJs0qWe7eTdXFb2Map4aNRczfiO
	638nKbjqm+g7WTzC20Xb+sghrI8eyMjxooPrtU1gKLt+A=
X-Google-Smtp-Source: AGHT+IGjNe4w/TZWClCQSXCO0edDTMBkbQhOnY+c8pbDSn5UW9W4Wf46Bs/AhhcRk7i4bblmszBZ6m7JuEbjAxmj0uM=
X-Received: by 2002:a17:902:ce85:b0:234:adce:3ea4 with SMTP id
 d9443c01a7336-23601da9a61mr93668205ad.10.1749550611325; Tue, 10 Jun 2025
 03:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609122200.179307-1-trintaeoitogc@gmail.com>
 <DAIQ9342ZFYD.3VQVI80A18HKX@kernel.org> <CANiq72kC1j-kprAQ5WU0QVV_zhyKfDPJ_M5E9xZ+8+fxt4R6qQ@mail.gmail.com>
 <DAIRU9INPO8A.1PLCLKFJJGODH@kernel.org>
In-Reply-To: <DAIRU9INPO8A.1PLCLKFJJGODH@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Jun 2025 12:16:36 +0200
X-Gm-Features: AX0GCFvnab1QEUDa9dFfE8CNMQFcfiIoOKuRWyWSIv2LB_UaenukRWb6fdKCArM
Message-ID: <CANiq72kORZjTe3tPEBueDi57TGF7KfxgTSw4Tn0DQeK_X5hi5A@mail.gmail.com>
Subject: Re: [PATCH] rust: module: remove deprecated author key
To: Benno Lossin <lossin@kernel.org>
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>, rafael@kernel.org, viresh.kumar@linaro.org, 
	dakr@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, mcgrof@kernel.org, 
	russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	leitao@debian.org, gregkh@linuxfoundation.org, david.m.ertman@intel.com, 
	ira.weiny@intel.com, leon@kernel.org, fujita.tomonori@gmail.com, 
	tamird@gmail.com, igor.korotin.linux@gmail.com, walmeida@microsoft.com, 
	anisse@astier.eu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 12:12=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
>
> Hmm, I guess a checkpatch lint fits better then?

Yeah, that would work.

Probably for the C side too -- from a quick grep I don't see it.

Cheers,
Miguel

