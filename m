Return-Path: <linux-pm+bounces-4474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B05E86A17C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 22:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715A61C22F72
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 21:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A1314F964;
	Tue, 27 Feb 2024 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GirU2AZy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CC14E2C6
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068869; cv=none; b=FgJ7PNS5mmMcVmp9ENdZiLKO2dkOfEBgNukw9DLUAZr0NF5AxJdSYHmSD7WKDJFoUo/CMunVMRa9E/hnB2nKmqiErnoU3bFAjuSaTtpTO2JHyHKBSz6Y1XTGCGGz1udZtP3p7V6bBcc8XtlepBfKrp6pSk2ZJwltQGgzcPv66pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068869; c=relaxed/simple;
	bh=LePJ+1rEauTeGpBluZGJ/sXyspjEoxSYSik3wlVN9kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQ6mavcyhpEU4oFgTAa9UViUkNAMxcbO6E8fb6sbDUVCyiov56/uaMegeU0hxRaVUqzPPviyt9c83A9wlQEhBh0LZY6DvpYJCF9e/0QfU0fymffOadOKVvm3b+4uNWeIQV4B8IuBZKsLiPWPaFcz/ZVelvxsns+QAy6Nbfz7Q0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GirU2AZy; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22007fe465bso1581264fac.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 13:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709068865; x=1709673665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fftOsJ681Wg1K7xzRX/qElJL1ndIu7jly7AsXPkBfxo=;
        b=GirU2AZyWc2Z2k7E8FG7XMB6wi2z6GRtQCNHpyjcrey1k7Cb+rZeGDC/ouy8Kz7Bgf
         ZH5Z+CYxS3uGHdjyHidmayhxjgSczNdwgdkjsWwuR4Shce1qnQmVRB5o2gZKa5P9R4Gy
         WSUeULlSv9h6F06pop0G+pB5ZiGWx6+fStjr66ZMIzopZVT+OxKU2WxrKPIvTkCn5UXm
         7FRiZNeF0F7aUtVyqB2POmv8T9RXXoYvWb4Up5lodkqTuWgI+GrvlcKKgA+lZ/Swe3SM
         qgxMMpBeqF1oJULV/5M/kH2ok/m7Voj62MvyDRJDP0k9JizBaPXu6LktLS/inkdoORwS
         HHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709068865; x=1709673665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fftOsJ681Wg1K7xzRX/qElJL1ndIu7jly7AsXPkBfxo=;
        b=vq5zu7cJ7BkXxY6xlX+3MjQAZvWwbUTpVCQhh2yhGBMlqW3tB+HeIgWye2S77UKrVM
         iLvukDybnv4LrV4LJo7wrUH8+yoB53/LDnJ1LNp/G76vdab0R8UtP4GQdR3hubHXNK94
         ZD47KOkGzUc1qqwmfleFtoTHtnbmy2hw8pGEeAc5ROHUatC2cNCJfqkZ9Y7JPr4yG8nf
         poeaGiWJSuHShLmH6FJquwSWtkZzC+WIEIB8JsDJH+PqHOQnqL85vxYlzUEusuXxJTva
         kTLXsDGhzcJWaCgc640bfXgGjXNwklnmmKnuff74/HFORCqe2eS3AiAnS368lQoa7Szz
         lP0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVBIe+iL8klI3P2Ev2dp2eQQwX/9+KrrZyVBdhuFdr232lWj83Nvwvokla+M+LmJg0AUzxniUkyNfHUHOyTvTpvRvDxW+4deU=
X-Gm-Message-State: AOJu0YyQ0R1RueofLCpQi4L/oR5uRBmru61cvwfPe/ibKWkJMVLR02yD
	RABitJyLfhNyoDsfSu05H1q/q5Psk/O/bj50P+Kgj0cjMj/IDyL3mdfKvI6yB/e/wY/8W5f23AK
	07qXDLL0IxcWIGrfhr6u9v5mq8/bKmKGRlslwsroFTCF5h2NrYTzowxQ=
X-Google-Smtp-Source: AGHT+IG02YkADIokrPJYriwvFLOKWZ0uiOqfajKlPmMYZTQxH2Tui/V1hyHlnbHfvbqU/RsPMb2q0QAOcsGXxi79+QY=
X-Received: by 2002:a05:6870:2249:b0:21e:6672:a46f with SMTP id
 j9-20020a056870224900b0021e6672a46fmr13175965oaf.29.1709068865281; Tue, 27
 Feb 2024 13:21:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227074204.3573450-1-li.meng@amd.com> <2aaa2a61-f753-4434-8c92-886fc4bb9aef@linuxfoundation.org>
In-Reply-To: <2aaa2a61-f753-4434-8c92-886fc4bb9aef@linuxfoundation.org>
From: Andrei Vagin <avagin@google.com>
Date: Tue, 27 Feb 2024 13:20:53 -0800
Message-ID: <CAEWA0a6D1YQtCuW1FswyGXXWNTrmyerNS3zzcqBPpyQ-GtOopA@mail.gmail.com>
Subject: Re: [RESEND PATCH] selftests/overlayfs: fix compilation error in overlayfs
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org, 
	Nathan Fontenot <nathan.fontenot@amd.com>, Deepak Sharma <deepak.sharma@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:41=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 2/27/24 00:42, Meng Li wrote:
> > make -C tools/testing/selftests, compiling dev_in_maps fail.
> > In file included from dev_in_maps.c:10:
> > /usr/include/x86_64-linux-gnu/sys/mount.h:35:3: error: expected identif=
ier before numeric constant
> >     35 |   MS_RDONLY =3D 1,                /* Mount read-only.  */
> >        |   ^~~~~~~~~
> >
> > That sys/mount.h has to be included before linux/mount.h.
> >
> > Signed-off-by: Meng Li <li.meng@amd.com>
> > ---
> >   tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> I don't see this problem when I build it on my system when
> I run:
>
> make -C tools/testing/selftests
> or
> make -C tools/testing/selftests/filesystems/overlayfs
>
> Are you running this after doing headers_install?

It depends on libc headers. It can work with one libc and doesn't work
with another one. I have seen many times when linux headers conflicted
with libc headers. The only reliable way to avoid this sort of issues is
to include just one linux or libc header.

In this case, we can do something like this:

diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index e19ab0e85709..f1ba82e52192 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -10,7 +10,6 @@
 #include <linux/mount.h>
 #include <sys/syscall.h>
 #include <sys/stat.h>
-#include <sys/mount.h>
 #include <sys/mman.h>
 #include <sched.h>
 #include <fcntl.h>
@@ -40,6 +39,14 @@ static int sys_move_mount(int from_dfd, const char
*from_pathname,
        return syscall(__NR_move_mount, from_dfd, from_pathname,
to_dfd, to_pathname, flags);
 }

+static int sys_mount(const char *source, const char *target,
+                    const char *filesystemtype, unsigned long mountflags,
+                    const void *data)
+{
+       return syscall(__NR_mount, source, target, filesystemtype,
mountflags, data);
+}
+
+
 static long get_file_dev_and_inode(void *addr, struct statx *stx)
 {
        char buf[4096];
@@ -167,7 +174,7 @@ int main(int argc, char **argv)
                return 1;
        }

-       if (mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) =3D=3D -1) {
+       if (sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) =3D=3D -1) =
{
                pr_perror("mount");
                return 1;
        }

Thanks,
Andrei

