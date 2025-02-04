Return-Path: <linux-pm+bounces-21341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B13DDA27719
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 17:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FC31883E5F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21622153CF;
	Tue,  4 Feb 2025 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3hFmP3H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCDB215196;
	Tue,  4 Feb 2025 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686370; cv=none; b=YKzFFBjZz0fcQpCtMBh1TZMkN0LnHkUadp9vCO8fCPWIyj3L25AqB/d3hUYAXB8deFK8l7G7bDUOPgkK41Q7K/8Dr1O+3pa0CGM5TJKMgo96b1hZ1T4oEKS3yC9UXx38ErR/WvV9xT9sc0mb620GYVS5/mWI5vy44wP+BelhSSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686370; c=relaxed/simple;
	bh=LxTw95Joq9NOwz1ssQz69DMOpY06Qewpmb9G+xXor48=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EEpoHGA5tdvGmYPZ++CERLs4k49oeY/cckcDnwHSTsqeNRnHK/j/1vxOLA7qgVGYQmdD1LOAFB4DfGP9GrI1a/uFUEpsUEB/lHDWvI7EUoDnAF5jeUYo/I8TDR4Z53lw3SBVswnfI746sHThSu6yVDvo+l8g1m2RDymER1EaELU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3hFmP3H; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaeec07b705so976251066b.2;
        Tue, 04 Feb 2025 08:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738686367; x=1739291167; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxTw95Joq9NOwz1ssQz69DMOpY06Qewpmb9G+xXor48=;
        b=K3hFmP3HyZbXWfq6RGy8CTjHkAmrFK7BvsRX5XKU/3lqTt15MXZ1JuhTZB9wSpm7BI
         zkdhhqeEkSJ2kacxp+zmhCmssBz2ha7O0mBbDdSlRQDPM0FD5yUI4WPQfy75vkKiYqBk
         9sCKh3096dSJLG3zfln/b0p+fzC6oUIzMawj5Jw5pY87HSEVhMBUuxM1Yu5wFrr0pxVQ
         Xt1UntOJONEH4Z2V38Ma3YNTtEL43lTmztYE30gWR+yBSHonOBG7s2R45Og4Nxt9eHW8
         4InguSqhEeDo9ZMc7CUb9y/xT6G/g3GePBf8Juf16x3qS99VV7ce7quZjfQOOt5pclnH
         +cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738686367; x=1739291167;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxTw95Joq9NOwz1ssQz69DMOpY06Qewpmb9G+xXor48=;
        b=i7w5ZnBTLRFD5evKIRLRt4oSrTOm4izhRkxV6VMmeMASBBPKfiTYyMHyyqwQYexj4a
         IxgqKmApSSkI3SfiwL+uDV+ZUZJ27yvPia4s7bkhUCZLtyEJhluR1g0Zdd7VayVirWNb
         OZPYtvJRI4iwZYiY2c60Bih5b1tLfqqZC/Dom+ZmFmQ5LtNO2cweRUH1epj8KJQth7QU
         Y5H07HcZnmoTCe+FwECthofjLrSdYg1i8Ee6k6W1LBZ7/olHCA18DTlqL9WnTSQ5clt0
         ME8xyB519Jw/r3fy+UKgej1xqsUODFGmrUSPMMTFcqtRvBV5t57cj6JwN8lJw1aKaW3B
         NaLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBuupOysOf4kTK0dpNEm86bENEG5CP12n+RfIZB8SIjYEqcIHhqOpX89SZ1nCYD9dGQyXHJfbsmxk=@vger.kernel.org, AJvYcCWZ+G78VFiZ9v7lnXjZ+HMTd8g4MuBkRoAYQyNqomtd2gDlUGykp/KlNVBI4qFHpDYAmbWenzIw6fxIg7gt@vger.kernel.org, AJvYcCWjB3pxa+E0Nfpa38S+A5U0lxxHqRKWRdeNkqnriF2gJbzCxuix8WeNTCiZgFaORqtAZiNBegkwjak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8N3bl0KkWdsbtMsZ4pdedE4fYUnrszbBKQjLn0uHMSgzUolNw
	T8IFNLtCa8XQnTsh6+wXpH18cH/3sccsER+wRPQ/1L2WCUT+Hixx
X-Gm-Gg: ASbGncuX2xnkXT8gbdiVr7ed54CXTkMR+ZmC8+Z4gMqr9S4ehXx38dtYUaoMTnxrLSn
	RHU7DhwjN7K2FDy201+jv8fhnQuOIs/ncx6Y0JivmXrNsWJN+bn55Mf9EvmS9A03zN7EGkirNGS
	92/5LZDXltofKaUeRUoU4FmAdmmMM1ZSpidmGtFeJdUKgD8ABKGjO7S63gdhTCY+EdsnDoam+Uu
	ofqhsfjzsxnfNdahqhF4WxGYtrB4Alu6sc78TMT9ci74vBYqEsbG9CYEicPgE0g5TV7yyVoNGJS
	IIqtLGQb/vp1dUBmNCdoSnZNnSWKHQktygPPE0qjtVQKWA==
X-Google-Smtp-Source: AGHT+IF/qxZnL8CdvHbhjCd17aP0gWz6HwZtAa27uqB0vv8GcyD52djUOcj4hDSHFe4syb77KiniZg==
X-Received: by 2002:a17:906:f598:b0:ab7:4641:a72d with SMTP id a640c23a62f3a-ab74641a76cmr604171066b.51.1738686366994;
        Tue, 04 Feb 2025 08:26:06 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a7ea7sm936628466b.5.2025.02.04.08.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:26:06 -0800 (PST)
Message-ID: <c894c5009c1fca50d80b1acdaa5e5d033a9ac7bc.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: introduce 'use_acpi_cst' module parameter
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: David Arcari <darcari@redhat.com>, linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, Prarit
 Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 04 Feb 2025 18:26:03 +0200
In-Reply-To: <afbe2137-398b-4053-93e7-2a03aeb32220@redhat.com>
References: <20250128141139.2033088-1-darcari@redhat.com>
	 <e9188365425d2a4c0dfa7cfa2b17ad3d9fcf2735.camel@gmail.com>
	 <afbe2137-398b-4053-93e7-2a03aeb32220@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-04 at 07:52 -0500, David Arcari wrote:
> I'm happy to resubmit. I guess I could use 'no_native' for the new=20
> parameter and then update the documentation as you suggest above.
>=20
> Does that work?

I'd suggest to wait for Rafael's response first. Thanks!

Artem.


