Return-Path: <linux-pm+bounces-4687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D687226C
	for <lists+linux-pm@lfdr.de>; Tue,  5 Mar 2024 16:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26961F22A2E
	for <lists+linux-pm@lfdr.de>; Tue,  5 Mar 2024 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23313126F11;
	Tue,  5 Mar 2024 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9oahAMa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA554683
	for <linux-pm@vger.kernel.org>; Tue,  5 Mar 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651295; cv=none; b=jAKyijHBZjr7UhAqW8A+Rd7i5jsVFJLsjtmXXr0T7Rx9Fbrd9QmXqXJxbhBlPa2pEExej0HwF3XxNdD3n/JYfEqjduX/tOrXxHmh7iKjbE3hmg50+rt1FeL0NmGZqq1spee3SzXqX3IPoeZ2CbDXNZXlnwjJ8Px4kx3C3yZfvvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651295; c=relaxed/simple;
	bh=ihFVVpOGjc9809fB5ocH4j682iFEx5PpDhNAo/vJhus=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uyXQY8g3iBA+NV+Xrz4DMp0kgMpSPg/W+XjQ+GfULJvA/j40je9jEc7UEEncg5YAWQ54KioahjVUlbPbGL2NoXwyDjn9spEn9sN5kU+sTLjAW9PMYm2D/vS41w0LWQqc2bqVD5g87ZuqhOOBdTS3yLMlV9kGUct/H4NY0EMLbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9oahAMa; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4515f8e13cso314350766b.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Mar 2024 07:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709651291; x=1710256091; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ihFVVpOGjc9809fB5ocH4j682iFEx5PpDhNAo/vJhus=;
        b=l9oahAMah6F9yUkX+mt1QF/3hKNQEYN00FTm2ORBYG9Q1+ngD654GO8h9RnWKDFDU9
         zeGWvxfb72lLKh5cQHSFJbYjN2Ex1saDvT9vgVP7wDHqLc1di19AQ0VMnRsyxQoAcI/x
         E1HniNhKLJQmeCs/EX8J8e9OlfyDl2CaRXqtgCsJDWces7mRzCVVxJm/nE11qoal70JW
         7m3fXjlZG3mZu2ZUfn8TnbvlycQX1QeUFLzlXqwNfXLQBgkE/raXLb9CJFF8G9hNaZGg
         Po51R592nmu+C+5w1TlYWTI0Lisgd1Ixoz8UGFPT4hfwb1CLLmaKvcWWDj1IhTg4Ch46
         Xdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709651291; x=1710256091;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihFVVpOGjc9809fB5ocH4j682iFEx5PpDhNAo/vJhus=;
        b=wiEUkkHZo1bnYS1FV3TTgaDSHcxKG3gQwo7Rztyj3xLjEkhAJF0OlCtUxzIScP29Lz
         AUylVSLOvdOQusbg9ZnwU8jp4VY8quUeGlOE+iN60qqQM+vto8xQsk6Ni99KYA6GrW8U
         sFGnwPaNX4p0TOfRxPNz67+VOdXtz6MDxraRHYPKGDLPzE+D5yHB7ZeJoio1smBNGfhR
         2xn9uLf3oTeUGSrNSrPeC+L38Md4f3hf7WCHRbDmETbExuDuEOerhBFOJiyO0+Fro6Xn
         ndunC8rN7CTKx8PNew6bqMhT4K+iHBoz2qirm5qdUig/UioWd0em/v9IZuI8O2Ow8h5D
         j2jg==
X-Gm-Message-State: AOJu0YwQ/hegIMepjrTsYrJWobVCPPaykx6b8eWV1QgYatDgkJfdQ6Vs
	DQpjl1HmLN5KK77W4297wEl0Hqh419Ut3GrmdAjG9e1SkWo1z1Klgi9RVDbExw0uGn/D3XDugIc
	pPMLbePjP1ySoSeEXQuEdo+Km13uGQObe
X-Google-Smtp-Source: AGHT+IE/s/ExAK2Rak6tnbw0O5F8zeN6bizSE1WnvFqvv2bVxse1tdVWHt6FgwxLz/ZrWg9xPUexSTG4e2Axr0SFNBI=
X-Received: by 2002:a17:907:1708:b0:a44:7e16:ae8c with SMTP id
 le8-20020a170907170800b00a447e16ae8cmr9021693ejc.43.1709651291425; Tue, 05
 Mar 2024 07:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Patryk <pbiel7@gmail.com>
Date: Tue, 5 Mar 2024 16:08:00 +0100
Message-ID: <CA+DkFDYxxXgBR=_u8a7dOUb5tFae0-Zst5eEiF4=pAid45sneQ@mail.gmail.com>
Subject: How to notify the kernel about upcoming power loss?
To: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi
I've got a question - what's the path or designed way to notify the
kernel that there will be unexpected power loss so that the kernel can
handle as much as possible before complete shutdown?
Let me show some background - we have a SoM which has a lot of
components. On the SoM we have a PSU which operates on 24V voltage. We
would like to monitor the PSU's voltage and when we detect that the
voltage has dropped from 24V to 12V this is highly likely an
unexpected power loss/cut, therefore we would like to inform the
Kernel (in particular mmc subsystem) that the power loss is coming.
I can imagine something like this - we have a driver that does voltage
measurements or waits for an external interrupt (triggered when PSU's
voltage drops from 24V to 12V) and then calls some functions that will
allow the Kernel to do some cleanups, but the question is what are
these functions? Are there any?

BR
Patryk

