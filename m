Return-Path: <linux-pm+bounces-39440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA68CB664A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 16:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8DF430024BE
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B7A313537;
	Thu, 11 Dec 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI0uKfIv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A207C31352D
	for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765468509; cv=none; b=pL+VmDnfZ6FiqTGRJrAr9nWXTMeDrvzTApHL1C/QLw9TpJ2cdrc0Xqu+ABlot9pvyWKuvh6JwhT+0aQdZ5HXYtjmpHcQUmxyzdRuaDjHdzfrUJPKdDbyEF/6yesc0P2bCBW0v44QtkzRq5QgcxFglpk58aoQSbGgNx8DwsBg8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765468509; c=relaxed/simple;
	bh=fwJlp95bBAG7kWYEepDiexqrENbAswzXKepyzd027WM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BoGuv7usE8ZnpuixlPAHzy3BA1Am5AbtJFVKYU9DsPCqoYd8N2NMKZ/PGGvUmOuEcWCP4OWH1omETnWfW/BO8zjOjedHX/IoO3Q37PhLrsgn7wail+OKgzFX5c+t0KGF7R/gGmlPvm/UwX9qjm9BhM4lAaBA1v9QQ5vMDlthVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI0uKfIv; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4503ee5c160so126624b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765468504; x=1766073304; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ie7TKY4J0xZBKToVZGBoQ4XnO54sW4jqYAqWGv0+/io=;
        b=AI0uKfIvYNqy0i8sBatIb5hKXR2JeAG7zgcLRBGC9YpVNU50w6jDy1+uXx190gkGOc
         C+W2rnF1QGAI544VrmsX5M+gVk0rwQKuICWqRohUd23lkL7owUcNbxUac8UsFzBrOBiZ
         dem1PKTAL0dNKLf1SM+gaLg/4Ain+mOrCswx3od/V7KBDT8XM9ei9epxd3bZB1DZUGWz
         6SxYmKUMk/U7MYsMYagGymf5dGK96Kjh1YAc4CjmChQc7rnYS9DAT3IlB7uHCNAYUZnB
         q+44VAQ9rnO+Azd5T//8uEj0bBGdavsBOTU2tKcnV96wMuOi4h1u96/xMIVQ5WtyTxxp
         t8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765468504; x=1766073304;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ie7TKY4J0xZBKToVZGBoQ4XnO54sW4jqYAqWGv0+/io=;
        b=Sq0V620dzf8W0rxff+U+BNhWgbSNcxJdL4r5W41VAkcTBQ2sgV4tP55R5aCZtgR2Sd
         OMmG/gUVBoAWlaYRPkGvtyY0OLY8vEwbpBemcvbJZHLnvtDDnCOAQkxX5xY5nOrr2103
         Vx3oxIfnsQdXlJRs5nRGLz9Rc/zoJN4Q8fzlDOrgOtXj7VMVQBeP7XruQ2YbrokZoXCA
         qBiKTCkY9TZTLIHEQaOad8v+352DLKLXZC5CNmeopTAGk7t//da6HBGXrVlTlp1n1yW5
         F6sVBTUpUuZlh63Zj3G0+vImadFiCGZo/UGZSk9ek9PUiGyvdr6us3jIB3uQl2VHRwnG
         lRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCR9C45ye7wQM6DwDzLR7PecNPOAlNph6FMhrahuhbvUpYWvD262YgCInmPsqe6JsaJSR4qM8+iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCK/9kPALvv05ZCWPrBB6yHyZkKNQNKZnwC3k/t6fOsVVT7KkR
	+/QIiGlHVca1QW190LVdmvg0CfMIMXarf4+07JU1SY3q0xo1G1PR9/Z2YWaUJ2DenKkSwkNbdOg
	BhDPwYjOtumnH8qdieeoYpvNXy8dqZ1I=
X-Gm-Gg: AY/fxX6s+bWqyX8IU8BeDumVHtMtq7DcRcdtta+eqXPQiVBSOYov1KtnntNslAiKL79
	GNWgy4aCyX1y4OYEtwU1cj63ooUE5M7kB0CwVVakL40TsA3R3L78VRGJeH4cRyRq759NzmhHKFE
	bnuytzfCV4fyBCe4UTTliNKI9yqP4Wk3+W9b+BZ30wl9hnkOzXkywCuPzwsI5UjxgxVv+g2XtfM
	7C+7OYhkvym0nF1DH9qETuEteUa2ekqC2VwLZSNDLP+sncYAjVo2Ls1AdQ0FseTUHsKnBjBYi01
	A0H/5rrJyPoa0+wt0S5RyVAbxw==
X-Google-Smtp-Source: AGHT+IHXmInc6hNUIZUoLpP+BYGgYAGze6nb2R2ueRO5VxDEQRxgtOjiPMFdP1lK2Otb1LgPycnughbDIgBoXGBKCXE=
X-Received: by 2002:a05:6808:1490:b0:439:af2f:d1d5 with SMTP id
 5614622812f47-455866d189amr3237813b6e.39.1765468504472; Thu, 11 Dec 2025
 07:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 11 Dec 2025 15:54:53 +0000
X-Gm-Features: AQt7F2ougg8Kbtn1zopP4MM0jMFAvN_Q8zACcGkXN_X9ACZRAZQLHfVWaA3hLE0
Message-ID: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
Subject: Concerns with em.yaml YNL spec
To: Changwoo Min <changwoo@igalia.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	sched-ext@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I just spotted the new em.yaml YNL spec that got merged in
bd26631ccdfd ("PM: EM: Add em.yaml and autogen files") as part of [1]
because it introduced new yamllint reports:

make -C tools/net/ynl/ lint
make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
yamllint ../../../Documentation/netlink/specs
../../../Documentation/netlink/specs/em.yaml
  3:1       warning  missing document start "---"  (document-start)
  107:13    error    wrong indentation: expected 10 but found 12  (indentation)

I guess the patch series was never cced to netdev or the YNL
maintainers so this is my first opportunity to review it.

Other than the lint messages, there are a few concerns with the
content of the spec:

- pds, pd and ps might be meaningful to energy model experts but they
are pretty meaningless to the rest of us. I see they are spelled out
in the energy model header file so it would be better to use
perf-domain, perf-table and perf-state here.

- I think the spec could have been called energy-model.yaml and the
family called "energy-model" instead of "em".

- the get-pds should probably be both do and dump which would give
multi responses without the need for the pds attribute set (unless I'm
missing something).

- there are 2 flags attributes that are bare u64 which should have
flags definitions in the YNL. Have a look at e.g. netdev.yaml to see
examples of flags definitions.

- the cpus attribute is a string which would appear to be a "%*pb"
stringification of a bitmap. That's not very consumable for a UAPI and
should probably use netlink bitmask or an array of cpu numbers or
something.

- there are no doc strings for any of the attributes. It would be
great to do better for new YNL specs, esp. since there is better
information in energy_model.h

Given that netlink is UAPI, I think we need to address these issues
before v6.19 gets released.

Thanks,
Donald Hunter.

[1] https://lore.kernel.org/all/20251020220914.320832-4-changwoo@igalia.com/

