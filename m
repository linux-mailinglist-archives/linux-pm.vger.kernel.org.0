Return-Path: <linux-pm+bounces-15614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39F399C725
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 12:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5731F23556
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C1D15B97E;
	Mon, 14 Oct 2024 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7/x9rlM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1581581F4
	for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901720; cv=none; b=u0u45/G6IFQe9S1kBYNpR2jHD1cobxMgQbIhrNf4+h/VylxNk94TYX+B/Rso/ZHHDFclR4uJZ5DL+GuhGwmzcIk8Nljn1TpuAA1G5NJMLUN4vqiP2UjGwWOxC5ahZE3kcG6i5JLUHinSqOsDrpcIoIi7MKtkolqRrQ9ZAJ5sNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901720; c=relaxed/simple;
	bh=WhDyfTRjdHhiECOrnWMKnYpaTc//VDik3ULegFlNTaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGgLviYA4xIfoRs65YsXRy6xdj4YyHvwJrvDnw+O9blYqLFCOIf6MnnEiffWqxL1rAI6oalHj92TM/hNHUo6yWsvecO0/sGf1WoTBQLUHXSHE7Ld8guwqvuI7POVsOzii0USydtYFohpD9mMRX9IBdSmiEtF+xl5QT4/8Yore9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7/x9rlM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cb89a4e4cso13435435ad.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 03:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728901718; x=1729506518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWWwDH82oJMReDPEBGrwZ6eQwvp6vhmDAyPgW2sjeXc=;
        b=B7/x9rlMKN0OSLdlKEUZ5zncEV5UdJbRhXVfPro1h046trRVwYb9QjhOw+qnISvdii
         B6r89B7jSLmG6dfQ5a9C0Qh7Bcc9R2ph9Lt/zfIjuCZRwkDMGpr3IXMeDBwh8QYjb8ZL
         5OgTfOaY8CWF5ylF/JE78/OGOBV/N1yO8z7KbQkieZRSH5T6cJzyMoHeyo6DEKR4zaOG
         zxyH75F6fG6P7RALG6jX+gfu83RNu4zyVdKTh71awipPYGEl8e4TIUqpZgxRPrrxRvCu
         ZIIiz5CvmCOczcRpo1iBfeiWOR6Fxg2vJeDGWJD/mZrjbkpWOD9nJ2r5o3UTX2nz7iXi
         vktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728901718; x=1729506518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWWwDH82oJMReDPEBGrwZ6eQwvp6vhmDAyPgW2sjeXc=;
        b=PpHBiUSSdESrDlqab6MxQJZlBkjLMCp4nwpC08IUT0uGXcn+czqhxTjSwKedKZYgaR
         Qx850acFIeZYB0OwiCkWGAWR0vGnTb8LySD666Z9IM1sJv9kU9B17o+0nMZq1oboXuMj
         KbHnbSLVl7X90UYSKG5TTJQx5/6XNkNUSWjdLvFJi1miBYOpUUZmuz24XRqLRXom+gMg
         NGO6y35pTew9GE2bS/ip65OsZ26nNUUPYSLbLNOzkjrjcoRXUStQHMg3ITIFB37/cCpW
         9fxKHFGWQUBY+8QKbP50vEABJeK6N5zPlB4SWw6vYZPHI2GowamAzo2mx6GS8L7LFliN
         OYOQ==
X-Gm-Message-State: AOJu0YzxBy7/npwNuaiID3wec4uDdHucVjjJDZciL2/Za3RyME2aPt5y
	daxNnhf2NTcNKPJJjj+5QKHrhakfh6DhGDkgbP+iY/V00y/mCn3gJeS5krTU9u7KnhigDnDMoL6
	FIstTebgiEaTfMYGjeTx8w0LQRrRK+CFB
X-Google-Smtp-Source: AGHT+IHarVCnqEH9tKz5RNXTZmO+aI+t/TB5SY8xNMTTngdyPOsz5qW7h7md/yGFOsrnLu2zINT1DICEVRQs/gItGvQ=
X-Received: by 2002:a17:902:e543:b0:20c:d2d9:766f with SMTP id
 d9443c01a7336-20cd2d977e0mr98208095ad.14.1728901717780; Mon, 14 Oct 2024
 03:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
In-Reply-To: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
From: Vivek yadav <linux.ninja23@gmail.com>
Date: Mon, 14 Oct 2024 15:58:25 +0530
Message-ID: <CAO6a-9-Gd44qiM7obURXwd8hrarZQ_8BpdbQPWQojh+yhO4oRw@mail.gmail.com>
Subject: Fwd: ARM64: CPUIdle driver is not select any Idle state other then WFI
To: linux-pm@vger.kernel.org, linux-newbie@vger.kerne
Cc: daniel.lezcano@linaro.org, lpieralisi@kernel.org, krzk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
From: Vivek yadav <linux.ninja23@gmail.com>
Date: Fri, Oct 11, 2024 at 3:14=E2=80=AFPM
Subject: ARM64: CPUIdle driver is not select any Idle state other then WFI
To: <linux-pm@vger.kernel.org>


Hi @all,

I am working on one custom SoC. Where I add one CPUIdle state for
``arm,cortex-a55`` processor.

idle-states {
      entry-method =3D "psci";
       cpu_ret_l: cpu-retention-l {
         compatible =3D "arm,idle-state";
         arm,psci-suspend-param =3D <0x00010001>;
         local-timer-stop;
         entry-latency-us =3D <55>;
          exit-latency-us =3D <140>;
          min-residency-us =3D <780>;
    };
};

I am using ``Menu governor`` with the ``psci_idle driver`` in its original =
form.
After booting Linux I find out that the CPUIdle core is never going
inside the ``cpu-retention`` state.
To check time spent by CPU in any state. I am using the below command.

``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/time``

OUTPUT:
0 =3D=3D=3D>CPU0 state0 (WFI)
0 =3D=3D=3D>CPU0 state1 (cpu-retention)

increasing some time value =3D=3D=3D>CPU1 state0 (WFI)
0 =3D=3D=3D>CPU1 state1 (cpu-retention)

increasing some time value
0

increasing some time value
0

What am I doing wrong? Why does ``cpu-retention`` state time not increase?
Any pointer will be helpful.

Regards,
Vivek

