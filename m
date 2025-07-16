Return-Path: <linux-pm+bounces-30900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C93B0759D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 14:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024BE7A2B98
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 12:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FD02F4A1F;
	Wed, 16 Jul 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5IH8m+k"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB07E2F4A16;
	Wed, 16 Jul 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668813; cv=none; b=gOpTP2Iinbx3+c/WfMB5tKfYSGmF1f4MbdRT1SE6KGs0k9rDR2TgO7jH+5Ui/QbVy3lNKWe5Yn8lTxhW/+sWEyRfUFDmlacUaUYKJL3/wntVTRv0k/yDZYZ6Tg8RphKEjrF/yEGE/XbUiFY1rGCa/WSXdcgkFJ1KwLO7j6tdPaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668813; c=relaxed/simple;
	bh=ZzbqDNnCWBZzcn8Y6iaRiFgK1P8Rg5fSwQT4soqN000=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+ulnF8ZuMvYGy/Fy3ho8EXZQwGescU44so/9Ok/9vQRQB7JCs2f54kJglAMy/Wv0/ER1goaOjgY81L26TGMpp9TZOd1rYw0AQKTHk/VHgjaE49KhloY/FyjtsY5ghWbeEusrVMqTBGdZSzORphFMTIpvTsUGd6fi6V2kRpMqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5IH8m+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5DCC4CEF0;
	Wed, 16 Jul 2025 12:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752668813;
	bh=ZzbqDNnCWBZzcn8Y6iaRiFgK1P8Rg5fSwQT4soqN000=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W5IH8m+kNWJFOJm8TWvJLYiGbvQVXxiDnp0s7Tf33gscaZYlaBlKaQVEA9P6RZ0Cg
	 oMgoudpa5/VoKl4y8667ndmu4xTPnkKk4ErAg5kEhAahZ4M6cPzAX7oNJORxovSifD
	 psXj0mm6lSQVpH4eVwnPOqkINp7WQI/u1raqpoE79Y4k4JrEJtAHwj7J3IoWI4Bfdg
	 6bFbOhCHEA74IxY7GvbDOOABVOuz35Vk5XFtINdyL4KJOSuFCAc0eDEAKORzDuagJg
	 x8L1F8ap9Sv2F0c13uvVQk3EP8IHJwj7JPxpSI3Vbpzr1p6pmt7bas0m4Or7yfUqYF
	 XIBs5u28S62Tw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-613b02e801aso3259461eaf.2;
        Wed, 16 Jul 2025 05:26:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURx8auNeuAvc/4564vht/HQ0A34cpTUPa/QVr6kUuYYsH/Ws/s5KpMElJCfyBk0fhmC9sjCdwp3Rc=@vger.kernel.org, AJvYcCXPmHc0a/pfZsaCCWgkyvI4ojMVubDYDyvg3dEo1+cvWvcstHKpe1jMiIgguBQDy9EvYecYFPQlIqfumfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRI8aS8u1RMzlqI2VPi+QFFuI13GWzg9CHEXQILGXiD+LSJvKn
	RasLg6fz+ljRuhpx5Fyz03ydEF7aoIcbkp6tVX0gykODMWl6wM/wwZcZzaU7BLPaOF6LYy3dZ7t
	e7Qs4z9F/h+9MhCxWj721w1QfV39DbOQ=
X-Google-Smtp-Source: AGHT+IHwt/5U6xFi/lU1KKpUJjT2fnVF8kBLZZuTBu8RxHGfeFh6MeOLYNSGt+O5t/HmQtWyI8vTfyOaE64HlJj5dAY=
X-Received: by 2002:a05:6820:134f:b0:611:7385:77a0 with SMTP id
 006d021491bc7-6159fe63a62mr1973490eaf.4.1752668812843; Wed, 16 Jul 2025
 05:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
In-Reply-To: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Jul 2025 14:26:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0goQ0DcsWAqn__E7CG=YcNAzdxo9bb-21q50V2H5CJ+xA@mail.gmail.com>
X-Gm-Features: Ac12FXzhl6Aq8hats4ivqXQPkPcOn36O0hEcPrggugc5AygPSBvqzmQtZd8tZu4
Message-ID: <CAJZ5v0goQ0DcsWAqn__E7CG=YcNAzdxo9bb-21q50V2H5CJ+xA@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] PM / Freezer: Skip zombie/dead processes to reduce
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 16, 2025 at 8:26=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> Hi all,
>
> This patch series improves the performance of the process freezer by
> skipping zombie tasks during freezing.
>
> In the suspend and hibernation paths, the freezer traverses all tasks
> and attempts to freeze them. However, zombie tasks (EXIT_ZOMBIE with
> PF_EXITING) are already dead =E2=80=94 they are not schedulable and canno=
t enter
> the refrigerator. Attempting to freeze such tasks is redundant and
> unnecessarily increases freezing time.
>
> In particular, on systems under fork storm conditions (e.g., many
> short-lived processes quickly becoming zombies), the number of zombie tas=
ks
> can spike into the thousands or more. We observed that this causes the
> freezer loop to waste significant time processing tasks that are guarante=
ed
> to not need freezing.

I think that the discussion with Peter regarding this has not been conclude=
d.

I thought that there was an alternative patch proposed during that
discussion.  If I'm not mistaken about this, what happened to that
patch?

Thanks!

> Testing and Results
>
> Platform:
> - Architecture: x86_64
> - CPU: ZHAOXIN KaiXian KX-7000
> - RAM: 16 GB
> - Kernel: v6.6.93
>
> result without the patch:
> dmesg | grep elap
> [  219.608992] Freezing user space processes completed (elapsed 0.010 sec=
onds)
> [  219.617355] Freezing remaining freezable tasks completed (elapsed 0.00=
8 seconds)
> [  228.029119] Freezing user space processes completed (elapsed 0.013 sec=
onds)
> [  228.040672] Freezing remaining freezable tasks completed (elapsed 0.01=
1 seconds)
> [  236.879065] Freezing user space processes completed (elapsed 0.020 sec=
onds)
> [  236.897976] Freezing remaining freezable tasks completed (elapsed 0.01=
8 seconds)
> [  246.276679] Freezing user space processes completed (elapsed 0.026 sec=
onds)
> [  246.298636] Freezing remaining freezable tasks completed (elapsed 0.02=
1 seconds)
> [  256.221504] Freezing user space processes completed (elapsed 0.030 sec=
onds)
> [  256.248955] Freezing remaining freezable tasks completed (elapsed 0.02=
7 seconds)
> [  266.674987] Freezing user space processes completed (elapsed 0.040 sec=
onds)
> [  266.709811] Freezing remaining freezable tasks completed (elapsed 0.03=
4 seconds)
> [  277.701679] Freezing user space processes completed (elapsed 0.046 sec=
onds)
> [  277.742048] Freezing remaining freezable tasks completed (elapsed 0.04=
0 seconds)
> [  289.246611] Freezing user space processes completed (elapsed 0.046 sec=
onds)
> [  289.290753] Freezing remaining freezable tasks completed (elapsed 0.04=
4 seconds)
> [  301.516854] Freezing user space processes completed (elapsed 0.041 sec=
onds)
> [  301.576287] Freezing remaining freezable tasks completed (elapsed 0.05=
9 seconds)
> [  314.422499] Freezing user space processes completed (elapsed 0.043 sec=
onds)
> [  314.465804] Freezing remaining freezable tasks completed (elapsed 0.04=
3 seconds)
>
> result with the patch:
> dmesg | grep elap
> [   54.161674] Freezing user space processes completed (elapsed 0.007 sec=
onds)
> [   54.171536] Freezing remaining freezable tasks completed (elapsed 0.00=
9 seconds)
> [   62.556462] Freezing user space processes completed (elapsed 0.006 sec=
onds)
> [   62.566496] Freezing remaining freezable tasks completed (elapsed 0.01=
0 seconds)
> [   71.395421] Freezing user space processes completed (elapsed 0.009 sec=
onds)
> [   71.402820] Freezing remaining freezable tasks completed (elapsed 0.00=
7 seconds)
> [   80.785463] Freezing user space processes completed (elapsed 0.010 sec=
onds)
> [   80.793914] Freezing remaining freezable tasks completed (elapsed 0.00=
8 seconds)
> [   90.962659] Freezing user space processes completed (elapsed 0.012 sec=
onds)
> [   90.973519] Freezing remaining freezable tasks completed (elapsed 0.01=
0 seconds)
> [  101.435638] Freezing user space processes completed (elapsed 0.013 sec=
onds)
> [  101.449023] Freezing remaining freezable tasks completed (elapsed 0.01=
3 seconds)
> [  112.669786] Freezing user space processes completed (elapsed 0.015 sec=
onds)
> [  112.683540] Freezing remaining freezable tasks completed (elapsed 0.01=
3 seconds)
> [  124.585681] Freezing user space processes completed (elapsed 0.017 sec=
onds)
> [  124.599553] Freezing remaining freezable tasks completed (elapsed 0.01=
3 seconds)
> [  136.826635] Freezing user space processes completed (elapsed 0.016 sec=
onds)
> [  136.841840] Freezing remaining freezable tasks completed (elapsed 0.01=
5 seconds)
> [  149.686575] Freezing user space processes completed (elapsed 0.016 sec=
onds)
> [  149.701549] Freezing remaining freezable tasks completed (elapsed 0.01=
4 seconds)
>
> Here is the user-space fork storm simulator used for testing:
>
> ```c
> // create_zombie.c
>
> void usage(const char *prog) {
>     fprintf(stderr, "Usage: %s <number_of_zombies>\n", prog);
>     exit(EXIT_FAILURE);
> }
>
> int main(int argc, char *argv[]) {
>     if (argc !=3D 2) {
>         usage(argv[0]);
>     }
>
>     long num_zombies =3D strtol(argv[1], NULL, 10);
>     if (num_zombies <=3D 0 || num_zombies > 1000000) {
>         fprintf(stderr, "Invalid number of zombies: %ld\n", num_zombies);
>         exit(EXIT_FAILURE);
>     }
>
>     printf("Creating %ld zombie processes...\n", num_zombies);
>
>     for (long i =3D 0; i < num_zombies; i++) {
>         pid_t pid =3D fork();
>         if (pid < 0) {
>             perror("fork failed");
>             exit(EXIT_FAILURE);
>         } else if (pid =3D=3D 0) {
>             // Child exits immediately
>             exit(0);
>         }
>         // Parent does NOT wait, leaving zombie
>     }
>
>     printf("All child processes created. Sleeping for 60 seconds...\n");
>     sleep(60);
>
>     printf("Parent exiting, zombies will be reaped by init.\n");
>     return 0;
> }
> ```
>
> And we used a shell loop to suspend repeatedly:
>
> ```bash
> LOOPS=3D10
>
> echo none > /sys/power/pm_test
> echo 5 > /sys/module/suspend/parameters/pm_test_delay
> for ((i=3D1; i<=3DLOOPS; i++)); do
> echo "=3D=3D=3D=3D=3D Test round $i/$LOOPS =3D=3D=3D=3D=3D"
> ./create_zombie $((i * 3000)) &
> sleep 5
> echo mem > /sys/power/state
>
> pkill create_zombie
> echo "Round $i complete. Waiting 5s..."
> sleep 5
>
> done
> echo "=3D=3D=3D=3D All $LOOPS rounds complete =3D=3D=3D=3D"
> ```
>
> Zihuan Zhang (1):
>   PM / Freezer: Skip zombie/dead processes to reduce freeze latency
>
>  kernel/power/process.c | 2 +-
>  1 file changed, 9 insertion(+), 1 deletion(-)
>
> --
> 2.25.1
>

