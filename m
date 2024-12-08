Return-Path: <linux-pm+bounces-18760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8699E842C
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 08:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F202281A71
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D904E1CA;
	Sun,  8 Dec 2024 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqE6gxQn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF298EEB2;
	Sun,  8 Dec 2024 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733644485; cv=none; b=Fh56TaGu9RclP4rF5/mQ4n5gREF/PNKXcByOHOy1y28SBJmUAf4p5lkEBU8JIuYEzq/3mUZyvgxkwj8LH38Y0CkMDFfS0Nfl/dQpPwje9rWm7gUEpuKtsq65IWb3bEHHB0YIQCB6OxCa0BcqfyCB0gOr6T1b9fzNuzzwR7LbWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733644485; c=relaxed/simple;
	bh=2juaYAzq0y55e3ru8WkiY+6F+WScBCBLuFR/2tiHgyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLOEcF2HaED3Pd4N3sKak3ZA3jibbrWpkxOdY1uOl8ZFdf6KP6Zcqtr7h0d2heT2iRXul+hYWawunxghtFcVeutfMv4A42IppOUQtrW14/NhU3ZKaUFKS9gAn0TK4cKSFK7G/PFHpIbKtyKis2m422wPvGbBTTXc7vTBU+foD/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqE6gxQn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so5304324a12.1;
        Sat, 07 Dec 2024 23:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733644482; x=1734249282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2juaYAzq0y55e3ru8WkiY+6F+WScBCBLuFR/2tiHgyg=;
        b=WqE6gxQnrwv/ZN1rOh65d+Y2btiQ/13T7Xv6i2K4pbCi+UJu54VGdbwLISItHRP3Fi
         UXTVf0DlF7svxr1KflzHHrIbkePMvreryv1DqCRVkB4oNBcgYHpaxOs4np3rOupVXWQa
         JLttWdwBK9eukAm5vrLHBJtzLZOnwDKSDZF1avaYWkXF7b0Hzho+KdSXXYwECveaDT7g
         CKLL2IQvle8KCW03z8opyNrrIjP5xJmc/3gQbX1O+lVr+uAK52J60Cq9m6O/UwL6U2+g
         D1SfuVE4/t/W998gn5DkppzrDov1qG//C6xD5dals/PtCBGqJ5N8Ne+iep9ztEn9Iqb/
         R43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733644482; x=1734249282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2juaYAzq0y55e3ru8WkiY+6F+WScBCBLuFR/2tiHgyg=;
        b=wQ3Kbjpm6fO/tU4OvXpk7sBDS8O4Dp2hlCzmjIDfdDD0SI9oFpIeVooyX+2U1R1v4a
         3AgCZEx2zSousV23R9TZEnaWzmCHqVdN5A3uM7idkgsw5zfSWWe2+UruRkiR4fssO0L5
         /TwAeQ+XFsgqQmyHWe2k+MDjMqWbTM7Alre1ATDHCknLSk51Q8MaOiZ7X0F9s5eAp5yB
         NLFxJNdjhPfDDZKVRLgf5WOR2h7ODcFEp9LVjEyWg/R3ouLrNc5vAHv0dwV9M4Gcrx6M
         UbMks54Q5QufLLCP06EjED69xUG4qtESFSNfjJNCNXT3Gbswl9Gbct77RQ62bf52WBFw
         O3IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwOCrG2Lh8hN6c3erIHyatMX+XW5KQgNqUoPSH9fqpiTY3D8Ru05vrUjnYfZI1RJRU8kK4cU5Z5nFoUnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL+uV3TC4qI7Q1yqHbpr9mnCo1cX606S4QLBqZKjRARd183uI3
	ulp2k4Lb01ts+mLS/pouFSbcmlsXHaPiB2eoZ6zN0bpTr8OZOmSyXMQPW1la
X-Gm-Gg: ASbGncvJ12/JKjaRcWaGQTmTGvkK2aYIfbsB0sHLTHmV6QOv6Wj9zZiheHsGSIlEP9k
	TwqZvRQ5k+WjkmfpvLQ8vo6mefEypNPyS03ZOd//Fo8o3ZODtzIh5ksPvQM8FltQUdjekTFSr/N
	oUhaL/smYU59vqx13Sk4i/oCy0/Vzu/OggbhyRDaZKx3o1vVNtT7MLWus8ybBsXlLGrQiIVyyNM
	ROWaeJ8SAHG4cx/joT/jAWcRhrxPgor5sWapCVuaqxwbOW/XJb9AgR0/Z2jfKz7YGAgJLB3WoQh
	yUpeqQ0kB0eWcbBhKl0NP7OlK1RLzo7XOA==
X-Google-Smtp-Source: AGHT+IFSPk6mYG/PHxHP6Xs2Q2ZU+AP7CzEmRU4+ps7Mu9mb8FtngyMq8uWvbGVd0Hq/CccrMlPREQ==
X-Received: by 2002:a05:6402:e81:b0:5d0:cca6:233a with SMTP id 4fb4d7f45d1cf-5d3be6b506bmr10059439a12.10.1733644481952;
        Sat, 07 Dec 2024 23:54:41 -0800 (PST)
Received: from 127.0.0.1 (136.169.149.122.dynamic.ufanet.ru. [136.169.149.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3ec8ef816sm995630a12.59.2024.12.07.23.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 23:54:41 -0800 (PST)
Sender: <irecca.kun@gmail.com>
Message-ID: <d89bfc1b-37cb-4d8b-b944-8dc385915bcf@gmail.com>
Date: Sun, 8 Dec 2024 07:54:38 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/2] cpufreq/amd-pstate: Set initial min_freq to
 lowest_nonlinear_freq
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241017053927.25285-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <20241017053927.25285-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello. Maybe I'm too late on this, but I have some concerns.

On 10/17/24 05:39, Dhananjay Ugwekar wrote:
> In other systems, power consumption has increased but so has the
> throughput/watt.

I just want to bring up the fact that this change affects all governors. It sounds good for the performance governor, but not so much for the powersave governor.

So the question is: don't we want the lowest power consumption possible in the powersave mode? Even if it means decreased efficiency. Powersave by definition supposed to make battery last as long as possible no matter what, isn't it?


