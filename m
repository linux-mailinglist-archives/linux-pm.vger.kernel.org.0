Return-Path: <linux-pm+bounces-28222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF8AD1160
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 09:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98F5C7A4D92
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 07:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBAC1CCEE7;
	Sun,  8 Jun 2025 07:22:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247ECF9C0;
	Sun,  8 Jun 2025 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749367366; cv=none; b=rv/3iovIjh2oqePO4ZPfriSva5B2+F3I/9V1ptDouU3kqsGEBQtMWKSxersfubvsxPeCe+N8C91jlbKXWZdVIsqOu/1ubvmhaZqaW/8+Gdct6UNA0Gqezu0bEhfnAQ91/OHD5hxWRtH0l33ICZc4HTrSNbKYJcB8lbNl5sdFeP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749367366; c=relaxed/simple;
	bh=O4CYZYV6794X5HlqbmtpnpZLenaFWHylh0+1GzjVfTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKwIP75nUOz72qsvNlWVJwWNcXa6Y8umJ43zWnmmMJpfYMSZT7d1vCARag0B5+702mgwsG8g9SaeA/G0qRiwlILYH5CYwSQFcXMQXLUTkSyJE+Lo1yWIDFmTgm0DMXlnTEDUF/KFjumtwWLdV0SCXFXdYOHy6W307vls4d7qLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 55502cb4443911f0b29709d653e92f7d-20250608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1ca3958d-2d35-4689-9233-86898a08e3fa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:223e149488ddad57fa4f24566d56519b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 55502cb4443911f0b29709d653e92f7d-20250608
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1180411814; Sun, 08 Jun 2025 15:22:28 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 13220E00891C;
	Sun,  8 Jun 2025 15:22:28 +0800 (CST)
X-ns-mid: postfix-68453A33-8140391
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 1A251E008900;
	Sun,  8 Jun 2025 15:22:20 +0800 (CST)
Message-ID: <6350624c-7293-43de-8788-e52a236d91fb@kylinos.cn>
Date: Sun, 8 Jun 2025 15:22:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PM: Optionally block user fork during freeze to
 improve performance
To: David Hildenbrand <david@redhat.com>, rafael@kernel.org,
 len.brown@intel.com, pavel@kernel.org, kees@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250606062502.19607-1-zhangzihuan@kylinos.cn>
 <0030581f-d50a-48f4-86f5-58e7883f705d@redhat.com>
From: zhangzihuan <zhangzihuan@kylinos.cn>
In-Reply-To: <0030581f-d50a-48f4-86f5-58e7883f705d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi David,
Thanks for your feedback!

=E5=9C=A8 2025/6/6 15:20, David Hildenbrand =E5=86=99=E9=81=93:
> Hi,
>
> On 06.06.25 08:25, Zihuan Zhang wrote:
>> Currently, the freezer traverses all tasks to freeze them during
>> system suspend or hibernation. If a user process forks during this
>> window, the new child may escape freezing and require a second
>> traversal or retry, adding non-trivial overhead.
>>
>> This patch introduces a CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE
>
> Not sure if a Kconfig is really the right choice here ...
>
I understand your concern. My initial thinking was to provide an opt-in=20
configuration so that platforms sensitive to resume performance (or=20
under constrained suspend time budgets) can selectively enable this=20
behavior.
However, I agree that a runtime mechanism or a default-on behavior gated=20
by suspend state might be cleaner. I'm happy to rework it in that=20
direction =E2=80=94 e.g., based on pm_freezing or a similar runtime flag.

>> option. When enabled, it prevents user processes from creating new
>> processes (via fork/clone) during the freezing period. This guarantees
>> a stable task list and avoids re-traversing the process list due to
>> late-created user tasks, thereby improving performance.
>
> Any performance numbers to back your claims?
>
We=E2=80=99ve completed the performance testing. To simulate a process es=
cape=20
scenario, we created a test environment where a large number of fork=20
operations are triggered right before the freeze phase begins.

A few details worth mentioning:
 =C2=A0 =C2=A0 =E2=80=A2=C2=A0 =C2=A0 We avoided creating too many proces=
ses at once to prevent=20
resource exhaustion.
 =C2=A0 =C2=A0 =E2=80=A2=C2=A0 =C2=A0 To increase the likelihood of hitti=
ng the freeze window=20
precisely, we skipped the filesystem freezing time during the simulation.

 =C2=A0 =C2=A0 =E2=80=A2=C2=A0 =C2=A0 We also added a small delay to each=
 process, ensuring they=20
don=E2=80=99t all complete their fork operations before the system enters=
=20
suspend/hibernate.

 =C2=A0 =C2=A0=E2=80=A2=C2=A0 =C2=A0 Before starting the tests, we also a=
dded a debug print in=20
try_to_freeze_task() to log the number of freeze retry attempts for each=20
task

--- begin test code ---

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <errno.h>
#include <string.h>
#include <time.h>
#define TOTAL_FORKS=C2=A0 =C2=A0 =C2=A0 =C2=A0 1000=C2=A0 =C2=A0 =C2=A0 /=
/ total number
#define BATCH_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10=C2=A0 =C2=A0 =C2=A0=
 =C2=A0// Number of forks per batch
#define FORK_INTERVAL_US=C2=A0 =C2=A0300=C2=A0 =C2=A0 =C2=A0 =C2=A0// Eac=
h fork interval (microseconds)
#define CHILD_LIFETIME_SEC 60=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Subprocess ru=
ntime (seconds)
void usleep_precise(int usec) {
 =C2=A0 =C2=A0 struct timespec ts;
 =C2=A0 =C2=A0 ts.tv_sec =3D usec / 1000000;
 =C2=A0 =C2=A0 ts.tv_nsec =3D (usec % 1000000) * 1000;
 =C2=A0 =C2=A0 nanosleep(&ts, NULL);
}
void random_delay_ms(int min_ms, int max_ms) {
 =C2=A0 =C2=A0 int delay =3D min_ms + rand() % (max_ms - min_ms + 1);
 =C2=A0 =C2=A0 usleep_precise(delay * 1000);
}
void random_delay_us(int min_us, int max_us) {
 =C2=A0 =C2=A0 int delay =3D min_us + rand() % (max_us - min_us + 1);
 =C2=A0 =C2=A0 usleep_precise(delay);
}
int main() {
 =C2=A0 =C2=A0 int count =3D 0;
 =C2=A0 =C2=A0 int batch =3D 0;
 =C2=A0 =C2=A0 printf("Starting enhanced fork storm test...\n");
 =C2=A0 =C2=A0 printf("=C2=A0 Total forks:=C2=A0 =C2=A0 =C2=A0 %d\n", TOT=
AL_FORKS);
 =C2=A0 =C2=A0 printf("=C2=A0 Batch size:=C2=A0 =C2=A0 =C2=A0 =C2=A0%d\n"=
, BATCH_SIZE);
 =C2=A0 =C2=A0 printf("=C2=A0 Fork interval:=C2=A0 =C2=A0 %d us\n", FORK_=
INTERVAL_US);
 =C2=A0 =C2=A0 printf("=C2=A0 Child lifetime:=C2=A0 =C2=A0%d sec\n\n", CH=
ILD_LIFETIME_SEC);

 =C2=A0 =C2=A0 random_delay_ms(2, 10); // Skip Filesystem freeze
 =C2=A0 =C2=A0 while (count < TOTAL_FORKS) {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("Starting batch %d...\n", ++batch);

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i < BATCH_SIZE && count < =
TOTAL_FORKS; i++,=20
count++) {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pid_t pid =3D fork();

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pid =3D=3D 0) {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("Child #%=
d (pid=3D%d) started\n", count, getpid());
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // sleep(CHILD_L=
IFETIME_SEC);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pause();
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(0);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (pid < 0) {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, =
"fork failed at %d: %s\n", count,=20
strerror(errno));
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usleep_precise(50);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("Batch %d completed. Total forked so =
far: %d\n", batch,=20
count);
 =C2=A0 =C2=A0 }

 =C2=A0 =C2=A0 printf("All %d children created. Parent process sleeping..=
.\n",=20
TOTAL_FORKS);
 =C2=A0 =C2=A0 pause();
 =C2=A0 =C2=A0 return 0;

}

--- end test code ---

Then compile the code and run the test script.

gcc=C2=A0 -o=C2=A0 slow_fork=C2=A0 slow_fork.c

--- begin test code ---

#!/bin/bash
LOOPS=3D20
DELAY_BETWEEN_RUNS=3D1
NUM_FORKS_PER_ROUND=3D10
FORK_PIDS=3D()
echo freezer > /sys/power/pm_test
echo 3 > /sys/module/suspend/parameters/pm_test_delay
for ((i=3D1; i<=3DLOOPS; i++)); do
echo "=3D=3D=3D=3D=3D Test round $i/$LOOPS =3D=3D=3D=3D=3D"

FORK_PIDS=3D()
for ((j=3D1; j<=3DNUM_FORKS_PER_ROUND; j++)); do
 =C2=A0 =C2=A0 ./slow_fork &
 =C2=A0 =C2=A0 FORK_PIDS+=3D($!)
 =C2=A0 =C2=A0 echo "=C2=A0 Launched slow_fork #$j (pid=3D${FORK_PIDS[-1]=
})"
done

echo mem > /sys/power/state

for pid in "${FORK_PIDS[@]}"; do
 =C2=A0 =C2=A0 kill "$pid" 2>/dev/null
done

for pid in "${FORK_PIDS[@]}"; do
 =C2=A0 =C2=A0 wait "$pid" 2>/dev/null
done

echo "Round $i complete. Waiting ${DELAY_BETWEEN_RUNS}s..."
sleep $DELAY_BETWEEN_RUNS

done
pkill slow_fork
echo "=3D=3D=3D=3D All $LOOPS rounds complete =3D=3D=3D=3D"

}

--- end test code ---

The result like this:

dmesg | grep -E 'elap|Files|retry'
[=C2=A0 585.255784] Filesystems sync: 0.010 seconds
[=C2=A0 585.261620] Freezing user space processes completed (elapsed 0.00=
5=20
seconds)
[=C2=A0 585.263530] Freezing remaining freezable tasks completed (elapsed=
=20
0.001 seconds)
[=C2=A0 589.323691] Filesystems sync: 0.012 seconds
[=C2=A0 589.336983] Freeing user space processes todo:0 retry:2
[=C2=A0 589.336996] Freezing user space processes completed (elapsed 0.01=
3=20
seconds)
[=C2=A0 589.342628] Freezing remaining freezable tasks completed (elapsed=
=20
0.005 seconds)
[=C2=A0 593.424317] Filesystems sync: 0.011 seconds
[=C2=A0 593.446210] Freeing user space processes todo:0 retry:2
[=C2=A0 593.446227] Freezing user space processes completed (elapsed 0.02=
1=20
seconds)
[=C2=A0 593.454303] Freezing remaining freezable tasks completed (elapsed=
=20
0.008 seconds)
[=C2=A0 597.528491] Filesystems sync: 0.012 seconds
[=C2=A0 597.561179] Freeing user space processes todo:0 retry:2
[=C2=A0 597.561200] Freezing user space processes completed (elapsed 0.03=
2=20
seconds)
[=C2=A0 597.570157] Freezing remaining freezable tasks completed (elapsed=
=20
0.008 seconds)
[=C2=A0 601.645391] Filesystems sync: 0.010 seconds
[=C2=A0 601.682653] Freeing user space processes todo:0 retry:2
[=C2=A0 601.682671] Freezing user space processes completed (elapsed 0.03=
7=20
seconds)
[=C2=A0 601.694401] Freezing remaining freezable tasks completed (elapsed=
=20
0.011 seconds)
[=C2=A0 605.789844] Filesystems sync: 0.011 seconds
[=C2=A0 605.830030] Freezing user space processes completed (elapsed 0.03=
9=20
seconds)
[=C2=A0 605.843602] Freezing remaining freezable tasks completed (elapsed=
=20
0.013 seconds)
[=C2=A0 609.942143] Filesystems sync: 0.017 seconds
[=C2=A0 609.997859] Freeing user space processes todo:0 retry:2
[=C2=A0 609.997875] Freezing user space processes completed (elapsed 0.05=
5=20
seconds)
[=C2=A0 610.016413] Freezing remaining freezable tasks completed (elapsed=
=20
0.018 seconds)
[=C2=A0 614.123700] Filesystems sync: 0.016 seconds
[=C2=A0 614.187743] Freeing user space processes todo:0 retry:2
[=C2=A0 614.187764] Freezing user space processes completed (elapsed 0.06=
3=20
seconds)
[=C2=A0 614.205004] Freezing remaining freezable tasks completed (elapsed=
=20
0.017 seconds)
[=C2=A0 618.323268] Filesystems sync: 0.013 seconds
[=C2=A0 618.393868] Freeing user space processes todo:0 retry:2
[=C2=A0 618.393886] Freezing user space processes completed (elapsed 0.07=
0=20
seconds)
[=C2=A0 618.413420] Freezing remaining freezable tasks completed (elapsed=
=20
0.019 seconds)
[=C2=A0 622.584589] Filesystems sync: 0.009 seconds
[=C2=A0 622.676274] Freeing user space processes todo:0 retry:2
[=C2=A0 622.676294] Freezing user space processes completed (elapsed 0.09=
1=20
seconds)
[=C2=A0 622.702762] Freezing remaining freezable tasks completed (elapsed=
=20
0.026 seconds)
[=C2=A0 626.836610] Filesystems sync: 0.009 seconds
[=C2=A0 626.935583] Freeing user space processes todo:0 retry:2
[=C2=A0 626.935603] Freezing user space processes completed (elapsed 0.09=
8=20
seconds)
[=C2=A0 626.966460] Freezing remaining freezable tasks completed (elapsed=
=20
0.030 seconds)
[=C2=A0 631.131669] Filesystems sync: 0.010 seconds
[=C2=A0 631.249412] Freeing user space processes todo:0 retry:2
[=C2=A0 631.249432] Freezing user space processes completed (elapsed 0.11=
7=20
seconds)
[=C2=A0 631.283333] Freezing remaining freezable tasks completed (elapsed=
=20
0.033 seconds)
[=C2=A0 635.459169] Filesystems sync: 0.014 seconds
[=C2=A0 635.574913] Freeing user space processes todo:0 retry:2
[=C2=A0 635.574928] Freezing user space processes completed (elapsed 0.11=
5=20
seconds)
[=C2=A0 635.613557] Freezing remaining freezable tasks completed (elapsed=
=20
0.038 seconds)
[=C2=A0 639.801842] Filesystems sync: 0.014 seconds
[=C2=A0 639.949023] Freeing user space processes todo:0 retry:2
[=C2=A0 639.949047] Freezing user space processes completed (elapsed 0.14=
6=20
seconds)
[=C2=A0 639.998032] Freezing remaining freezable tasks completed (elapsed=
=20
0.048 seconds)
[=C2=A0 644.151229] Filesystems sync: 0.011 seconds
[=C2=A0 644.303744] Freeing user space processes todo:0 retry:2
[=C2=A0 644.303765] Freezing user space processes completed (elapsed 0.15=
2=20
seconds)
[=C2=A0 644.347925] Freezing remaining freezable tasks completed (elapsed=
=20
0.043 seconds)
[=C2=A0 648.506472] Filesystems sync: 0.010 seconds
[=C2=A0 648.647752] Freeing user space processes todo:192 retry:2
[=C2=A0 648.670978] Freeing user space processes todo:0 retry:3
[=C2=A0 648.670997] Freezing user space processes completed (elapsed 0.16=
4=20
seconds)
[=C2=A0 648.724734] Freezing remaining freezable tasks completed (elapsed=
=20
0.053 seconds)
[=C2=A0 652.947466] Filesystems sync: 0.021 seconds
[=C2=A0 653.112034] Freeing user space processes todo:0 retry:2
[=C2=A0 653.112055] Freezing user space processes completed (elapsed 0.16=
4=20
seconds)
[=C2=A0 653.163845] Freezing remaining freezable tasks completed (elapsed=
=20
0.051 seconds)
[=C2=A0 657.364792] Filesystems sync: 0.012 seconds
[=C2=A0 657.510491] Freezing user space processes completed (elapsed 0.14=
5=20
seconds)
[=C2=A0 657.570268] Freezing remaining freezable tasks completed (elapsed=
=20
0.059 seconds)
[=C2=A0 661.779728] Filesystems sync: 0.011 seconds
[=C2=A0 661.975654] Freeing user space processes todo:0 retry:2
[=C2=A0 661.975686] Freezing user space processes completed (elapsed 0.19=
5=20
seconds)
[=C2=A0 662.050074] Freezing remaining freezable tasks completed (elapsed=
=20
0.074 seconds)
[=C2=A0 666.273377] Filesystems sync: 0.010 seconds
[=C2=A0 666.481081] Freeing user space processes todo:0 retry:2
[=C2=A0 666.481117] Freezing user space processes completed (elapsed 0.20=
7=20
seconds)
[=C2=A0 666.564340] Freezing remaining freezable tasks completed (elapsed=
=20
0.083 seconds)

We observed the following log during one of the test runs:

[=C2=A0 648.647752] Freeing user space processes todo:192 retry:2
However, since the reproduction rate is currently low, it's still=20
difficult to quantify exactly how much performance improvement the patch=20
brings.

>>
>> The restriction is only active during the window when the system is
>> freezing user tasks. Once all tasks are frozen, or if the system abort=
s
>> the suspend/hibernate process, the restriction is lifted.
>> No kernel threads are affected, and kernel_create_* functions remain
>> unrestricted.
>>
>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>> ---
>> =C2=A0 include/linux/suspend.h |=C2=A0 8 ++++++++
>> =C2=A0 kernel/fork.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 6 ++++++
>> =C2=A0 kernel/power/Kconfig=C2=A0=C2=A0=C2=A0 | 10 ++++++++++
>> =C2=A0 kernel/power/main.c=C2=A0=C2=A0=C2=A0=C2=A0 | 44 ++++++++++++++=
+++++++++++++++++++++++++++
>> =C2=A0 kernel/power/power.h=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
>> =C2=A0 kernel/power/process.c=C2=A0 |=C2=A0 7 +++++++
>> =C2=A0 6 files changed, 79 insertions(+)
>>
>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>> index b1c76c8f2c82..2dd8b3eb50f0 100644
>> --- a/include/linux/suspend.h
>> +++ b/include/linux/suspend.h
>> @@ -591,4 +591,12 @@ enum suspend_stat_step {
>> =C2=A0 void dpm_save_failed_dev(const char *name);
>> =C2=A0 void dpm_save_failed_step(enum suspend_stat_step step);
>> =C2=A0 +#ifdef CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE
>> +extern bool pm_block_user_fork;
>> +bool pm_should_block_fork(void);
>> +bool pm_freeze_process_in_progress(void);
>> +#else
>> +static inline bool pm_should_block_fork(void) { return false; };
>> +static inline bool pm_freeze_process_in_progress(void) { return=20
>> false; };
>> +#endif /* CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE */
>> =C2=A0 #endif /* _LINUX_SUSPEND_H */
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 1ee8eb11f38b..b0bd0206b644 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -105,6 +105,7 @@
>> =C2=A0 #include <uapi/linux/pidfd.h>
>> =C2=A0 #include <linux/pidfs.h>
>> =C2=A0 #include <linux/tick.h>
>> +#include <linux/suspend.h>
>> =C2=A0 =C2=A0 #include <asm/pgalloc.h>
>> =C2=A0 #include <linux/uaccess.h>
>> @@ -2596,6 +2597,11 @@ pid_t kernel_clone(struct kernel_clone_args=20
>> *args)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 trace =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +#ifdef CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE
>> +=C2=A0=C2=A0=C2=A0 if (pm_should_block_fork() && !(current->flags & P=
F_KTHREAD))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EBUSY;
>> +#endif
>

You're absolutely right =E2=80=94 returning -EBUSY is not part of the doc=
umented=20
interface for fork/clone3, and user space libraries like glibc are=20
likely not prepared to handle that gracefully.
One alternative could be to block in kernel_clone() until freezing ends,=20
instead of returning an error. That way, fork() would not fail, just=20
potentially block briefly (similar to memory pressure or cgroup limits).=20
Do you think that's more acceptable?
I=E2=80=99ll draft an updated version reflecting your suggestions. Really=
=20
appreciate your time and review!
Best regards,
Zihuan Zhang

> fork() is not documented to return EBUSY and for clone3() it's=20
> documented to only happen in specific cases.
>
> So user space is not prepared for that.
>

