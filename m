Return-Path: <linux-pm+bounces-4553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C49CF86CACF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 14:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65FC1B225E0
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8B912AAEC;
	Thu, 29 Feb 2024 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B21s5rSs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9C12A17A
	for <linux-pm@vger.kernel.org>; Thu, 29 Feb 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215123; cv=none; b=Wtynd4ExsR4kGxg4enLg3NP8KzlVYHywVxwQgKCojXOz9kmsz9w1gsQWhp1lJm2F3s18pHhvqGJxox+phyopblyL2p7kGor7lSQYQhUZ/HLu/5isfEgtzTfngMvkEqrSQZp7C1oCmzrv8CQ1QKUTHoVAT24LTAHiUtmC0YECgvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215123; c=relaxed/simple;
	bh=nh3+nbVDSeFQJfQzAqJuzdIYfJaV9IDLCyOr3FiNK0o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F99B/U8hSflySRsR+0D1z2ETwVyLYKZqPOWWx9CZJapnLKWxZjWK31RIJoLu+JNj1OO9IMTYDcN0vyjuWtfuYj+0s1gycC87q05AnUmINmljaJYGBqXee+OdzD2p7GPykA8EesfgKnisuLK/deTlhc2+L3sKB0I/1AWb7UWvufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B21s5rSs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a43fc42e697so131106466b.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Feb 2024 05:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709215119; x=1709819919; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nh3+nbVDSeFQJfQzAqJuzdIYfJaV9IDLCyOr3FiNK0o=;
        b=B21s5rSsUakz2Ny6XEq+z+6T3NM3ZlN+aZSCRR3SzmDimVt1Db5PNJ6qWLVVsIL1+Z
         mYJTIEhd+EB4/vYjd/RTPX93xIOqPVJ59dKL1MqTGeBGOKrgYH42RLWQgU/ghfd8gMFy
         tAORUzw8nEDoNRy04WBSixRJFKX2ElcwK7aiFgJ4NNLZKRABpzaNGtph83YTrzKd6loz
         X++TklMPxZ7QR7RSyRWJJF8f03EdqTT8OJVJUsL5mRckPZfCpi/8b7QoKLLuXo0c/5cM
         NX7Nm5tvwtpTOnHqSxRhmCAa9knuklVWIoo5xGkgqE/1PJDSc69IMhbA+cbD6TJnTdQL
         vBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709215119; x=1709819919;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nh3+nbVDSeFQJfQzAqJuzdIYfJaV9IDLCyOr3FiNK0o=;
        b=A0LBjCem71nu0JEim675EEy8mZ3UYKPiRk2DuFY8zVmT7D9bQ78Py3CqEWCM1vHOxd
         ZONX8w8rSQ+fj+85Q4AZm7I3tiSDKKYzpitHRdTEwxLPDor1du8d5N1WHdwxM2VaKQVO
         7Svky/lyV/2Y4qKbwxlMPIzaM21KQwICAxWm+JyREQzLWwswjlcrQ4ijvMEVi1XUAetx
         7/2/ffGOWMZdttYEEd8Dy3yDA6k3WphTiWeaEcWkzKUOo+XBz6w3KDK9/i0XWTjMoEWm
         UuQ8iPiTgZPK7ECVXRGT4t6E+ocArHgEkJQsJ6ZtELZCxACFln2rxyw7pxmGQipc+D8m
         nNeQ==
X-Gm-Message-State: AOJu0YyiuCUrUoalS95xA6oNzEj2csdR+pnJgsA5ku+S2tv++GlOr8Qw
	lPIcBpDdeJKiBjcwts/+gE/Bb3PNUuFurk9ANj/uGwOvVFiRYVRolZfNk+eRjMvqW0lFXFlhfef
	CseC55DZvHez0IBBz34KAAwN9Va3iDthRw7GCHcB3HOE=
X-Google-Smtp-Source: AGHT+IHmKoNBN72M0Qan+e/2vF7HHgOYOCV8ep41QNdml+kkK+1WrPiKyIANpbdeJhtbMH+uvNN0vrwgZ9rqKS4f+fQ=
X-Received: by 2002:a17:906:b891:b0:a43:f170:bbdb with SMTP id
 hb17-20020a170906b89100b00a43f170bbdbmr1619050ejb.71.1709215119315; Thu, 29
 Feb 2024 05:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lee Adolph <soslordos@gmail.com>
Date: Thu, 29 Feb 2024 21:58:27 +0800
Message-ID: <CAM1MrdTMEWTovaFT4BNBWA9stRWMrqSOas29qwsDsObgAawjtQ@mail.gmail.com>
Subject: 
To: linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

unsubscribe linux-pm

