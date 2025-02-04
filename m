Return-Path: <linux-pm+bounces-21347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368B8A279EE
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 19:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B8B162597
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 18:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E60217F29;
	Tue,  4 Feb 2025 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ucUPB19Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E13213E81
	for <linux-pm@vger.kernel.org>; Tue,  4 Feb 2025 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694091; cv=none; b=a9vLPNoDE8Dbw5C7w2ouQmJX0VUWIvYE+0WZxhRA77qc7xIuNeRO0EfCqdOiSOl+WZuhKCKHtRPCyHFbt1NgRgR8uDrnQL5jHsp9OGYx0w9xbEbg7WhHortjqen/du6hWbbajI8GkQgRzgn6fAhpgECLCZi0KD2RruoL/UCTtE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694091; c=relaxed/simple;
	bh=qq6/0sgx5ZwS3YIlvXs2lDakwhUURjUKrwBBStrGj7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNbxCjqpM8JxRcvsWTmVqwUFfPKUuy4lo1r4OjhjhRD2xLuEe4ufpjlpVGAg6iogTT59BRpOroK3uxwNV/9REseByo82C7zQkccwWwpEdoR4mhhho1W4LlD6c4kciHmPfcHSEqTc1xEiLU4PcHcdKPyfDMTCuul0+dKpHQsz3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ucUPB19Y; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d008738e03so54853165ab.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2025 10:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738694087; x=1739298887; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M3rTMe+j/2oa4I6gF8pPtcv0zI3NJYxIm/hZ5P5q3zo=;
        b=ucUPB19YOxYZUMSig59vhoVuBBxfo8GuBjZFosQu9RkvExjHqbv/1hX9ytNvqOjyn1
         K9ZEo5cq/IgvteWICnY7IKhr7xmEDm3cBGb/HbSY+9NY9Hkc2rJ/8UaVEsnn85ct7b3/
         ASY5MkZSNCl+RgFPIq6sXpj1k3l8P7uroATRkZTrg/JVGx9mSotkG0TiRj7BjlN81nO8
         aAF8ocPn3PlDJ7NWXzFqPTHIA5UHAJ6nQ267kpm/Z21rxJ1tbvcLgL/83BSqVRRl33Ft
         QBfoTX7bb6bzv5hGCuChDUcb54Y6tKPZpJymg0SxFvlOmGwuhu2yYXsZefxnGNUaHeWt
         GVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694087; x=1739298887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3rTMe+j/2oa4I6gF8pPtcv0zI3NJYxIm/hZ5P5q3zo=;
        b=oCOuVqSg1oqjqfVMfPWepPPuxb7Fs5I/vli4+9tJy+GKgHdVG5UBMug3MBA4DzX+GD
         R/IL9pFCSpnKhEa4HVua19O/vJ2wgZlLDl8MV4I0AZ461loiCaU2e2UJbZhi3hM/WeWY
         7QbJDl077BzAtod1q1dnuSN2z4oEuMFDDyQ/suI3gxnP0ZaKk2GMy/gAlwUsUxBjAAAK
         YQ+IxxHKzMUf6UZX93SFqPloV4B+e8rfEWtySAVdtz8HqRaYb3biDZn/snThvkTjlDAY
         jcJ26BTJ59w7JIyRg9uCbdkcc/RuXvjNfF7oEH5iexjNLAxTwsekSla/KO1vn+uxOdQV
         UUuA==
X-Forwarded-Encrypted: i=1; AJvYcCVxaGKM41je7+il4OJyi0XOepMptaJi4VmhVMO9A7CiDuk4o+ZJJD+XrXAHDp2uWgovER77RRTukw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoV+kbPYkuWbh+EG8CAtCaHfIlhC0oEX3CAsp0IYXiVmKvDgUI
	/o0wbTQEVVlSc3lR452Hcvppa7w/2oxEAtPiMsej3hFtKBJ2CWONbjHcGMYLiyk=
X-Gm-Gg: ASbGncu5SI+ZZDq365UgCw8rBMlMckn3Qs8IG8l1mLbBbU/TKyon4zwHqOAvuxFr1ia
	5G270uVD5rtsK0bA8TXfdlj7MW16AwpSD1/ISWgP6Cq5vkX9dB/q9mQwqqY8BhkaEj4tl2YUHAm
	XkuDW1zUdA7UG4DiaqJthjcOsuB/cYWJNrF2C3taW6BWMvBR8Rq3WE2LaezKBgDx3XvyznN0Gho
	IC54OUWreen/Ypn6nzvSXdsga8xX3EpqB6ulWn0M4Yzkixc4/agN8Rtvuxskmc21ESFq/6WBII8
	44cekA==
X-Google-Smtp-Source: AGHT+IG/BRPtaEZnajjDcpobEpuNb3M6MK2S0ZW69zYjb0ka0RxhjRkwp9wRSC5O0Seo0pB1mdptYQ==
X-Received: by 2002:a05:6e02:12eb:b0:3d0:47e3:40bb with SMTP id e9e14a558f8ab-3d047e34217mr16450115ab.4.1738694087183;
        Tue, 04 Feb 2025 10:34:47 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d00a4fd453sm30576535ab.4.2025.02.04.10.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:34:46 -0800 (PST)
Date: Tue, 4 Feb 2025 10:34:41 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Quentin Monnet <qmo@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] tools: Unify top-level quiet infrastructure
Message-ID: <Z6JdwSsAk1xCiSrn@ghost>
References: <20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com>
 <CAADnVQKTqRBQBA-yxB9EYPMgayP3rOE4iDhg+QD++2d=jxfY=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKTqRBQBA-yxB9EYPMgayP3rOE4iDhg+QD++2d=jxfY=Q@mail.gmail.com>

On Tue, Feb 04, 2025 at 05:18:42PM +0000, Alexei Starovoitov wrote:
> On Tue, Feb 4, 2025 at 12:10 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > The quiet infrastructure was moved out of Makefile.build to accomidate
> > the new syscall table generation scripts in perf. Syscall table
> > generation wanted to also be able to be quiet, so instead of again
> > copying the code to set the quiet variables, the code was moved into
> > Makefile.perf to be used globally. This was not the right solution. It
> > should have been moved even further upwards in the call chain.
> > Makefile.include is imported in many files so this seems like a proper
> > place to put it.
> >
> > To:
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > Charlie Jenkins (2):
> >       tools: Unify top-level quiet infrastructure
> >       tools: Remove redundant quiet setup
> >
> >  tools/arch/arm64/tools/Makefile           |  6 -----
> >  tools/bpf/Makefile                        |  6 -----
> >  tools/bpf/bpftool/Documentation/Makefile  |  6 -----
> >  tools/bpf/bpftool/Makefile                |  6 -----
> >  tools/bpf/resolve_btfids/Makefile         |  2 --
> >  tools/bpf/runqslower/Makefile             |  5 +---
> >  tools/build/Makefile                      |  8 +-----
> >  tools/lib/bpf/Makefile                    | 13 ----------
> 
> Nack.
> libbpf and bpftool are synced independently to github
> and released from there.
> This change breaks it.

Can you explain how it breaks it? Currently bpftool and resolve_btfids
don't build quietly so this was an attempt to fix that.

- Charlie


