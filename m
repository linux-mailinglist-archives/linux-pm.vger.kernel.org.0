Return-Path: <linux-pm+bounces-21962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D011A3263E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 13:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1E4188C5F5
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8D320D51A;
	Wed, 12 Feb 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/aI0ou3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F420B811;
	Wed, 12 Feb 2025 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364575; cv=none; b=WwaQyAj+czfq+5jTqpscqCm3++025Sz1MRynHAql0snqeyPSBKHF+4W/xJXMT7udLp08XgYzoJWyAEAmTb3AsP+sLG3/7sERHdnZABp+FIpBozm9YcA44vHdUZGxe0TM6bA9mTGI//B/b2/GCliHtcLk2GwZGOJ3Vr4yX1uioU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364575; c=relaxed/simple;
	bh=VW6/4SSPyMS8p+Z4LCMrj3Xot8dO86al4y2tfmsilwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aEINLaV0jB/ek3ABkZVu/SeTR2pW/6noVHWtHnaoSqOQYGNlyjHDc3Fakbgj4U4f58Nah+jQBZ/K5J9/c980WLVnciryZXxoDual1zaC3yZJk4pky9HCTeM7u4RhpTr2qQx5J1q59rAFhjQgz30iNW0tU7Ea03xwlItHBsrBJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/aI0ou3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7f860a9c6so94580366b.0;
        Wed, 12 Feb 2025 04:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739364572; x=1739969372; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW6/4SSPyMS8p+Z4LCMrj3Xot8dO86al4y2tfmsilwE=;
        b=M/aI0ou3GMo8pCozWpLaOMoY10Rq8c6MwdRNpUHHkqSMtpj9q//4wlMrT2r0zGMpOR
         INL7Q9BOwyDZ483H4+XX/x09L8cewoeicD5CAUA5JwNvUBEmctUonoZNSXURn04n0y4S
         KhbWvzC3orguOxZmY05QC85InyQ4Y91D9rTuZqTS8x1XOnGpmVQ0TSXpAE9iPWpB4fhF
         zzNGFwY3Sf27nHI3Xa2NFFR3UGqYSEbbFa/1z9j1V0p0Q0vt9qmkPaz2MCPxHB12Q4nm
         bJJS8Xc/mJ+xf6y8Yrju1lOz3LMXZdlBbK4TT+D0d5CGLNELmFC/WQ18rVLtgJIKPp8D
         Yu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739364572; x=1739969372;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VW6/4SSPyMS8p+Z4LCMrj3Xot8dO86al4y2tfmsilwE=;
        b=FwN2pjnLv9i8SSkrhTsi7r2GZXuUkdmvOowgHMIouWQFQTerpYyK8tL53M0hZ6EXjS
         fWZ54SFrlhyeWsWKGjvYeDwnMGuZ7H0A6FNx1pFmILzIigKZkQw6oep1S94crKPs1DRo
         QvxUxeOpBQZMklJjN9c1btTkpVE3C5X7FxC1gfPRvxHXun+uOK7Rz5Azz5ncv6e90iGi
         TsynmMKh/fkE75WJcmLdFUmACuVTUTw/+Z8QdLKen4/sc78JW80pITuzHq2o27TaW5gt
         hL3U/HIvnXzTwB07kxdpcxmgRA+MT+BPK82upewwpqYlovX3p1qCOloKBRNftU4PzpGA
         SA+A==
X-Forwarded-Encrypted: i=1; AJvYcCUCVWPtwXn3b0CEWKZ3Wf+DE5WZXNeV1D99vIjGBbfgpjButvB92jqARX5Dmw5pVPxI/LhupnzibDc=@vger.kernel.org, AJvYcCUX/R45KN4xfLJDsfMh24MyEXrX2jQqcW89GRJodzFl00yrhdywo7U/7pfNMsC5ZnRxAK4GS+GEcLA=@vger.kernel.org, AJvYcCXe8t7Nor0UoTi83ZYXcVDfxTUF1caDFRsg0n4KV+O0rQful2hlG1/ZGl+WpmgWrDCTOacasRyN8HbKh57l@vger.kernel.org
X-Gm-Message-State: AOJu0YzmHj205mR9qFMzbPA1i6K2GBtNTv5w/j5+owUazB6yJOz9vBwH
	ex6q9C03Qn81l14280sTQXRTpPuV61FYVkYiJaQreE7wMD0sHhZ6
X-Gm-Gg: ASbGncuacY4anStOHsd1og00HVhtIxvhe4qUOZ+C56YdJhHiKjKkC6+0f4I16fXZmd2
	uHxyN3TqDuei+zz+iirA37hM0JplgY43Yms5FI0TOJnHdLnqmJMuA8UlK7zIYGeZliyhFhq6huW
	aSWnrOdTxfNZ18Vc3ofFurUG3nG40Xwk7B+g2cg14gZ+/dAKWfUbpaoUFhz11uZt4euamZxK7TO
	zCN6RnaZKry0u2Ay7fZ5PHC5B1VEyBiT/cbrJkGF07JjA9rI/phfU7xHELzatH3/7oJICZdDZEO
	HVohKG1xblrTkHKx8aqRojuYjdE/RjVGqhQO3pcSu0sC/A==
X-Google-Smtp-Source: AGHT+IGciLXRAMb8IklxQt1qty8/NJhkxRO9Bik+gJhazg+83ZCzyCcKAnHH+OicOMzD4U/tmZgrIg==
X-Received: by 2002:a17:907:6d29:b0:aae:c3c1:1361 with SMTP id a640c23a62f3a-ab7f34a0d1fmr302302366b.44.1739364570890;
        Wed, 12 Feb 2025 04:49:30 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7cd7ffaa8sm499724566b.132.2025.02.12.04.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 04:49:30 -0800 (PST)
Message-ID: <e1877881efdf56490650f564e9d218abd0673893.camel@gmail.com>
Subject: Re: [PATCH v3] intel_idle: introduce 'no_native' module parameter
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: David Arcari <darcari@redhat.com>, kernel test robot <lkp@intel.com>, 
	linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>, Jacob
 Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, Prarit
 Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 12 Feb 2025 14:49:27 +0200
In-Reply-To: <9416ee48-a68a-465e-85be-89d5a53afcd8@redhat.com>
References: <20250211132741.99944-1-darcari@redhat.com>
	 <202502121732.P7lZkbhm-lkp@intel.com>
	 <21e66060c13c6a3cc33592f71cb08975711a6adb.camel@gmail.com>
	 <9416ee48-a68a-465e-85be-89d5a53afcd8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-12 at 07:41 -0500, David Arcari wrote:
> - #ifdef the code that doesn't compile
> - default no_acpi=3Dtrue in the !CONFIG_ACPI_PROCESSOR_CSTATE case
>=20
> I sort of like the second option better, but I worry about the=20
> documentation.=C2=A0 Specifically:

The most important part is build !CONFIG_ACPI_PROCESSOR_CSTATE, run and tes=
t
that it works.

Thanks!

