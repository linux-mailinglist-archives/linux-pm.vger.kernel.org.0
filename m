Return-Path: <linux-pm+bounces-36004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60306BD63F1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 22:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86B044FC3C5
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E980A309EE1;
	Mon, 13 Oct 2025 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSA9v8dQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E32FE59F
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388279; cv=none; b=E8VDcfMqGhAAKftP+04qZb9V8mWRdXTaK+mKML8SC5BmpeAI17z70rkj4mltrTGKWVOF1yRepoyq/DEYFKnNfc9atTePMg3U0y3wUmPxRCZSrnHnko1Sxzdyxdjo06n1Ebj7iXRk1zNew2WS5V9FQNekPR6LQlDUMWbHSg7IFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388279; c=relaxed/simple;
	bh=9hay/0JIfknGgWYAyMDi+RRa32y7nL7hZHKUlG5JnX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syHy0Ef3UPw6g0KpgRD3zQ6EVjK1blMs41eiTlTN7HNMD+cQ2fKOGUEibd/Yf2PcW3QA9QV4E5NReC2uzUu+6zFd3PiNpZxODjK/kaa95wSY5q57DO4VGcBUNgfgiTnPbPA6Eqx3zHERXNlX27bc0ySW9PaSy/oW6PZNGzB/CWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wSA9v8dQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4256866958bso2594149f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760388276; x=1760993076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9hay/0JIfknGgWYAyMDi+RRa32y7nL7hZHKUlG5JnX4=;
        b=wSA9v8dQf6O1yYRyuKW3CRU1veMgj6HQEXi1tSKruyHFiieY4baFGRW+QIDkkbxeGr
         mqbNENk94Ch7ocGYsurhvv12j4GXhYCMCJs/WTfSzDMha1voTLKRiSdob+7zYsS1D7Y5
         ond+/0INdY1a9Orwg07aL7Xc7Bs02t3eS5qOsLS9zBmibWZsDh6iTQkmYWFSXY+gz0Is
         CI96hIbLbS3nNoocslWRpS8SYODK2wFXq0uZLbM5GyVRAX3+MgTr9vzACiXszjQ+s9GJ
         hGzIsLrHJx317X+w0ifB2z1On/iGZNbWfCs/snllZfZMHt81boM9oI1NrnJJgCuAMTc3
         gYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388276; x=1760993076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hay/0JIfknGgWYAyMDi+RRa32y7nL7hZHKUlG5JnX4=;
        b=XQSaqtzitbghbqUkqVOYyy6OhXNVF9sGw6UWnyGcDbSV52NSMf5Q+s9sIY7nD8kpm8
         uxag7NwFKgkSNmlsL870AmbF5L7zR1x31EnFGCJmlOLp/dks4yjry/hixAR3Rai3FAFz
         CsPrmjPSod/zPmj5lS5BxACr3mw6DirI33EpqduxkPedDFQELu1O8xPk4yaLGl1dfpBM
         UT7bX4G57ls0f216q9KukNqmP7GaRQikrF58evDHhLdsPohU2xrg9gC2VEtJlGErrQZr
         G7/vyfFSJqs242V4okrHXfc6PvFgPhQsbj2liFrnBua5yjypHxZcwe9akKQKtPyDpe4H
         7mGA==
X-Forwarded-Encrypted: i=1; AJvYcCUpUcjTVMo7s1DMs5xJ6aw6c5cJ8qt1200RNpbQO/yPvtGDTc0c+DceAJV6+pFWMSE4D42gGRgYdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEgd0BCtoIBCyP8kWpdreHu5M9mGKSDBL6zH/kcES1pJbulUqG
	ITviT5fc80rzD44ywB1w0nVx/hCs5mlxIcCdbRXv+BguBr0EXFMs6068Y731fdbHsFjLitcSfWO
	olGkpsVbbXpm4998qC3hnwud/jtrUbP54BMNtkmS1
X-Gm-Gg: ASbGncv+bwwMtRCiOqX+Zjq9wlOhfeczxG23XyJFan8+uqpesQaeO6viUg+qgo30bJe
	mXgE3vv637NW7VIIadRwPLk44zTP51s9hzcTVD6328Jq4VjBgWtgseh8FSp2meljIkjnO2Pkyww
	e2gUHsFdoL+ek9fbYvw7QR8HwcriKRBdn0CEtPGf/mE8oBJCkIdsx79GT932gWj+vzxPzeGWYfL
	qbhcW/HH8rPrdFUM1bOiz5+oIHQv3HJXBcM5rfmrZ0LTlwMQp4OfuoiyvJMHoJUlITkV8pNEg==
X-Google-Smtp-Source: AGHT+IH1jaLuUviRfQbDoA6NkOlm+qkv87OVo2UlFWcQ+L0Qmlm8gTytxE7e1laTJS5cXlaHj5g++60FMQSaieI/SWQ=
X-Received: by 2002:a05:6000:430b:b0:3f0:4365:1d36 with SMTP id
 ffacd0b85a97d-42666ac9d80mr14319200f8f.16.1760388276152; Mon, 13 Oct 2025
 13:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com> <20251007000007.3724229-3-jthies@google.com>
 <aOZgy-ngtrilVQ5N@kuha.fi.intel.com>
In-Reply-To: <aOZgy-ngtrilVQ5N@kuha.fi.intel.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 13 Oct 2025 13:44:24 -0700
X-Gm-Features: AS18NWCU9ewVmTl79PE142H5oFVAZ-jo9n41HkuLJQx9P7yXDul6gDppIar6RSw
Message-ID: <CAMFSARf+PMOJHc5FtnSB0hCyGVnguNrTada9RuAba4Zy4XCm+A@mail.gmail.com>
Subject: Re: [PATCH 2/6] usb: typec: ucsi: psy: Add support for DRP USB type
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Benson

> Do you really need to iterate through the whole list of pdos to find this?
>
> The DRP bit is guaranteed to be always in the 5V PDO, which is guaranteed to
> be the 0th one.

Thanks for taking a look. This sounds like a good optimization, I'll
apply it to the v2 series.

