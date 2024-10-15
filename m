Return-Path: <linux-pm+bounces-15711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FCD99FA99
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534AA281B01
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EBF21E3AE;
	Tue, 15 Oct 2024 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcpnoY+c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA321E3A9
	for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029347; cv=none; b=alemO3SahXo2Z8nuUd8v7xqDxjiBDQvPvy4CMOuVR/LAYWUb0LVV6yvan9KdD8Y28zW/4gWpEVcxnpMQFjCPz/4AAJkmNityDY974ZxoyCGfcUxXPFtg1FaaFZ8Idv+EQKTjHQTo1/rG29UrKCg0Ee6wlaCdaNPiF8rx0v4DFn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029347; c=relaxed/simple;
	bh=qHRnhbszZKcsp4cxRYMFZSKdOLyFy6ls1byVkbi8Xu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8TfexMq02OEpfK/BFw/yj8KzWmwZ2xgsd9vje11180LH9c97WoLCoUCljGPESSJpHmaSoxGbQsjqrLBISoV5v9iI+Cmrvy1ok608zOl8mxwdvIFN7oRLQoTDzR/b7NUwNWlfWqgkxg7etRzusbG4EoRtbULcagum5bp9X8n56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcpnoY+c; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e28fe07e97dso5723666276.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 14:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729029344; x=1729634144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nzS8omj502CzRg8Z7h49g2zbbcpsWx40TDj7+qwgpMA=;
        b=lcpnoY+cBWTGcVWMvGll3iZylDn7t0Z8Zf2dNV5hmqHr3o5VlUZN4peY8gusQteotI
         bKcwwgwmTHUh7ex00AoqQT4l1Ca0q2LLeMWua9A6MgYMc3WNOwGoQ1f2HjAzSJJ8byhG
         Kmm3y8WvEnXK3YCAo9vyLs4L/J2+Nrv2Yk5CQEtRC/4gfHBZqfoSNTk/WrdICAvv+kuR
         8L8SJi0Yq0gTrJpKNczglWnDJeG/RrF/+GT3leabPBYMC03g99N8QtlzPscoQIXLhWmx
         jkcDMZyhdXwu3zHexZpll6lqwKwU1ofK0EPRhXqrQLb0MfHkW4tIIL8XrzYM73WZZxRc
         Lsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729029344; x=1729634144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzS8omj502CzRg8Z7h49g2zbbcpsWx40TDj7+qwgpMA=;
        b=uK4rYxh7zzCnQVMS2+qpWpGbU+qp/N540QcWZsvzulhJ7rz9SUADsTett0kmKE7s3Q
         M3CfWr+x5106Xu3I9P7d3MTf3sX1fNVmne/naImYmVPXtFQ+RZNIDq/C4zb5TspQU89+
         9qsD2NAcUfLu0HWoUbybt3eYeFeH5sWFn2fCD612enmiKqCHnYXO28zjVLgEeXZS31ef
         b5IH5BTGfMLrILaGNQl1/3Wi3NEO5D780WTyJEQrlfGj6pBip2amFTn6PDyubH8f5Wdk
         kfHNWtMWSi18czYBD0+e9XgrK+5W5Bp4Z+t5dePuwaN1G7C/0zeIMWzslnp3fpb+sju/
         u2XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM/5ZMo65V1/GFmH6jmS350LGm9z95nkmowEtf1KqSZZ6vJRKCi9IZ5THg0dqI0NsNE/U5ZAn5bA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb2f1A1LWR/H8MfjUdi1RoCrHU3m441LlrK3x+sY5w6ZaBi7up
	9cLrxdUhgaJgAWOR84nWHlhoZG0l/wK6eij1YT0Bx0QjIY++rzjkeTNJIRiGgSxx0dvZ1F02FFt
	0kf/kmRdAf5Ag/0l0PpPUuJOsko8=
X-Google-Smtp-Source: AGHT+IFS+1UkipUMPqTcBJrCmRnysgz9Zwo3AfZ0TDnzvjw4hO6Qj0mUTHpWvwj/mF+gl/qCqSfDuv699czVBo8rJgw=
X-Received: by 2002:a25:d0d5:0:b0:e29:769b:453a with SMTP id
 3f1490d57ef6-e29769b4a30mr1844511276.35.1729029344383; Tue, 15 Oct 2024
 14:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015163854.35204-1-simeddon@gmail.com> <Zw6rNVJ1iIjLr1Y2@rhfedora>
In-Reply-To: <Zw6rNVJ1iIjLr1Y2@rhfedora>
From: Sid <simeddon@gmail.com>
Date: Wed, 16 Oct 2024 03:25:09 +0530
Message-ID: <CAGd6pzOpjEnU-iOeVEmWbaLfWaSQExkEhqREOHXP-7Qkp3AsvA@mail.gmail.com>
Subject: Re: [PATCH] cpupower: add checks for xgettext and msgfmt
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: shuah@kernel.org, trenn@suse.com, jkacur@redhat.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 23:19, John B. Wyatt IV <jwyatt@redhat.com> wrote:
>
> I tested this on a Fedora 40 server. I was not able to get this message to
> print despite xgettext not being in the path.
Thank you for testing out my patch. The .pot file for cpupower is required
in order to enter this code block.

Should I  send in another patch to generate cpupower.pot in the makefile
itself?

Resending my previous response as I accidentally left text-only mode
disabled.

--
Sincerely,
Siddharth Menon

