Return-Path: <linux-pm+bounces-17105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2429C051A
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 12:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228FE1F22DCD
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C217820EA2C;
	Thu,  7 Nov 2024 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLC6fX5e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547320EA3B
	for <linux-pm@vger.kernel.org>; Thu,  7 Nov 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980752; cv=none; b=g7qTfIngUWWiiafXjBaCV85G0saVtU2x33/AkjH+mVCO4Ayq4aQ+wK9wLDMfFTK+1oU3Aux/dt2HtWL0Sq99puw/EMhZ16ntbS6S0wX7N5l83UG0PjKT3RU2SIMOwcoNaWI7fF22PXg5lPEx0Q1hfLYK2sMdigYqDUQc2Q0gROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980752; c=relaxed/simple;
	bh=bMKHmudAPkJIxEpdBowwFHf3h1OAn33qMUuJNIfDCrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q973WiriYNVoAEuoldlt6jc0VJOJAitMAZNw0yrK3+C7EUbqsD0rQsnjqO/5l9Y7LMv0/ftE2OeMCGvs15GWIhhi+am/AglXcxC0NpT6Q2+D6CGdj0j2sb0pt05lFhhggDOB5gS5ZEbZ6Ef1MOyXjE5ORZkVz5Nxx0S6yqGPJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLC6fX5e; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9ec86a67feso142886066b.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2024 03:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730980749; x=1731585549; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMKHmudAPkJIxEpdBowwFHf3h1OAn33qMUuJNIfDCrk=;
        b=jLC6fX5epwSzB0pDigvFFCtP3DwxQxgm3RbwTdSxAklleuHg3U8QcxQYiz8IMLdvPx
         VVdkLo0LPdzuYAl//LXm4LnwefHJUlxqUM5zFUQQY7zsw2gisYbPgskvY8wekFI6xvXN
         +E7nId9SSZQXHOqOGI4LmcrmEidpyfgebx77GhfSv+qX8M4dXXs5FCK8s/w4C6A0qtSf
         WwcqNQsxL1pOnRcjHKVpZ90N48ghwB5+v7cfRaKCT9JEgJYMV8/DEi3+kwezsdbEK6gi
         Xp1Es7wIsQd9M3s2207RYTkVYHEVBPD5MBKhQB2oerrYvUrai263Po9Wc6YOR3t731VB
         jx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730980749; x=1731585549;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMKHmudAPkJIxEpdBowwFHf3h1OAn33qMUuJNIfDCrk=;
        b=S5kv2MEB5DRWFw2EhXjzGc1XXm2tYYRbzLXoaSZh5AuUQBAkRV64UUyXqqJe5EVSlc
         Evf+WY5YR7iH/hThJFAaPijoB4IxTsS67HKDujgozhzvzs7oQ1eQwDVq2gkNYWhSpwud
         3GmjvRtLi7HpygMpSPoB0/vyElMHgJKA+syzBY6ctVLPyCCLyQbkfxztGdZcPobQ25Ou
         eueOc/pvbwCOReYPwvnPZgoIghy5zSHXos0iCmfziVMM71vbLKiTkhKWTFuK57EYhggr
         Xcp+Rh2bJf+buhEb2jwaT+4PdyKeMmuc2nB8QukKRsKTwoPi7eCUVDIo5l0yjLZA95is
         n2Hg==
X-Gm-Message-State: AOJu0YyLt1IduHZMmOjaDE4eFXf7l1egTkt3Mx7SCB4JwQF52Ndl/0gl
	ty0U/hoo8TJfjdICsdHrcZW7s5CsaLKKnDmS1A54Iaafn0AZDrOq
X-Google-Smtp-Source: AGHT+IEDQXIIvAa2h1Y9pHFYM828utDyRFqASuAdX+tk24PgLIL7AIRwhKlXP6y+rBNx3y2xzCe+ig==
X-Received: by 2002:a17:907:72c2:b0:a99:f67c:2314 with SMTP id a640c23a62f3a-a9de5ee34d7mr4587963166b.35.1730980749181;
        Thu, 07 Nov 2024 03:59:09 -0800 (PST)
Received: from abityuts-desk1.fi.intel.com ([134.191.197.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dee4a2sm83379766b.136.2024.11.07.03.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:59:08 -0800 (PST)
Message-ID: <fc4039a725b77374f36d6934f944db40f643e303.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: add Granite Rapids Xeon D support
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Date: Thu, 07 Nov 2024 13:59:06 +0200
In-Reply-To: <20241107115608.52233-1-artem.bityutskiy@linux.intel.com>
References: <20241107115608.52233-1-artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-07 at 13:56 +0200, Artem Bityutskiy wrote:
> Add Granite Rapids Xeon C C-states support: C1, C1E, C6, and C6P.

Oh, just noticed a typo - should be Granite Rapids Xeon D, sorry. Rafael, i=
f you
pick this patch, please amend the commit message. Alternatively, I can send=
 an
adjusted version. Thanks!

Artem.

