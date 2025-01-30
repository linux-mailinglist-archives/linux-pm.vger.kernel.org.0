Return-Path: <linux-pm+bounces-21127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198C0A22CB6
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 12:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429AA7A17EA
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 11:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519621E2847;
	Thu, 30 Jan 2025 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0KyyF2ZT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECE21E0DDC
	for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738237901; cv=none; b=JRl8927pLdUSjNCkrkdbz2A58gYdSquz83i7+t9YBNyt25ZPSnwp5WoLmuew6FamxGmz5b7HMcvkUePkGTp8pGk2o+81CMD+dGrIFdRYhJ9gm04apufPskQnvZvBTSEzXzkmD+0+QrhghTHA4qXbJNGADwyH0kIyTqrU0oiQAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738237901; c=relaxed/simple;
	bh=kGp2+R8eNNhmvEcrIQ7enrgR9LeawhDbjVgF/jZ7XEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwYSZxiBrSXuaZQ2u7W5q+/N/r6NPAbpDkwAfHC2mQHWPj/Uz3Q/lGTF1SvgiqE102K0lOBghwJTQk4cVjtuob9X5CRG/UNpHR11zqetEQ2rQAj+n838hA5Z+K+WtZYc+6egi7PA+QMFzWVs6m/5JCGprE0Ylr31VDx3o0l8Cqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0KyyF2ZT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e3621518so377192f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2025 03:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738237896; x=1738842696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGp2+R8eNNhmvEcrIQ7enrgR9LeawhDbjVgF/jZ7XEA=;
        b=0KyyF2ZTXtAliCYtKppP1UDT1DstkB9PA/ygWeChsBSCiAhfaYBx4Il0htF+se9BS8
         iRGuOkSBAXRGUtDJuOvNa9qg79TcqrAIlfnhz/XK7/3sJCle1D4b1V+YCvOzwJpFI/MN
         nd1IiguCrJ0FYlpv9nCPYY+k+QMACHmyn5ElOBpe+Crhyfdx6YR291np4pS0uW9f4utF
         qCRuIMwIhYeScQgyKznx9ZkIQhhxN/+J866DCKQOxyxbIm+b7zb9WQBm4UQ8EXJi5maZ
         iUxopc8drWhzLONtbcIKNH+llSLtH5EnbRdujCHgV2NcXIdtF0C7xPz579JEJQvNwPtw
         Tymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738237896; x=1738842696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGp2+R8eNNhmvEcrIQ7enrgR9LeawhDbjVgF/jZ7XEA=;
        b=eEIU3uJABFCvNgcrWoB5Tv55sYa/Zu71E6dv71j/feKVmzXAOeRcY1bzDn9mW831V4
         3btH6QqEASpNU0F892emOpkl0+T8zhirkFLMh7g6rjSR8kCGtMFXlVPGFfAWsBrMQPpU
         n25gr3ZRRqF8Su/YW533Vv3U7Ci+miJJkwnFD+v4osTEOKdNiFdtSNVk5iS2omErTNv8
         FEjR8oMLpe3nVBaXPe7HN9V6Za1sxulk0rbdO7jPa2OedLJAWPV36nsg8D9gzgLKmrtc
         Bx6B1uirhYF+xUH2QBuQsW8IA3HuouOA+U0DNiiVkK+eIA8wLKtj52npUDg2ltEBjFAJ
         ercA==
X-Forwarded-Encrypted: i=1; AJvYcCWydb44bsAiiVqoq1j9SRG0a28wzS5OP8sI0/uYCDfzsNEqV4dI+gTiRAn61feonF7PD1Hs5tLyHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4yia0w7DYSeFLWCpFyyYzGBlmiwc8oqb9Ry2NCv/qBoJ1LV8u
	Z9g51Nhj/oxiZ2F39WCoSgXHMv23kUV2KGeCyilKY+eNXJ4og1OFYPKgfRWrCl2asdtkY8xXGw8
	liCGPg8Z89nmfzPftoI9UgQcbESqiG80RcMVM
X-Gm-Gg: ASbGncsMo3ZRF7+liJZ2Y6jpfyjiECx1Tto3ZfkCplfmbfRIW9P9OXWFefwdJShl7Mr
	vyycvFTp9w7oRhU+oqEhKObHGmIS0fMmBSskNoiWYr/kOiYY5sTYVkpOi8MEftQ6Mb4jqViHE71
	deUzEA3gNWokeKZsNVsurE6dZ73xc=
X-Google-Smtp-Source: AGHT+IGvhsMDfSw2waYNiEI+BbQj09q1Fmdbt3AaOePv6Ibw4RBOxEFXo20jAmJyvPKbzZHhQGA6ztql9g5ekL72F2A=
X-Received: by 2002:a5d:6d0b:0:b0:38a:8647:3dac with SMTP id
 ffacd0b85a97d-38c520940bcmr5783375f8f.34.1738237896495; Thu, 30 Jan 2025
 03:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122131812.466080-1-anisse@astier.eu> <20250122133952.501055-1-anisse@astier.eu>
In-Reply-To: <20250122133952.501055-1-anisse@astier.eu>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 30 Jan 2025 12:51:24 +0100
X-Gm-Features: AWEUYZl8PktkmFWhIXon5Mf7gRkSIqN3HjonYckcGOQRDHSq3NA66Ohjeks3P0k
Message-ID: <CAH5fLggCtpLJhh7eD+kaM-e54=wCHFVJU9drmZuZ=kaKvzEQ6g@mail.gmail.com>
Subject: Re: [PATCH v2] rust: macros: enable use of hyphens in module names
To: Anisse Astier <anisse@astier.eu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 2:39=E2=80=AFPM Anisse Astier <anisse@astier.eu> wr=
ote:
>
> Some modules might need naming that contains hyphens "-" to match the
> auto-probing by name in the platform devices that comes from the device
> tree.
>
> But rust identifiers cannot contain hyphens, so replace the module name
> by an underscore anywhere we'd use it as an identifier.
>
> Signed-off-by: Anisse Astier <anisse@astier.eu>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

