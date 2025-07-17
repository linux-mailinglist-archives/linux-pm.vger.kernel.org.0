Return-Path: <linux-pm+bounces-30964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 756B6B081FD
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 03:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4073B7C50
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 01:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D150A2AE96;
	Thu, 17 Jul 2025 01:02:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3AE28E7;
	Thu, 17 Jul 2025 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714163; cv=none; b=t8nFavvblB8Hor+0f/KBF+kUHlESxKpokpkGXSXDverZXpIUpZd7T7JzRHga9gJcZoQoM/sRRm5dhbcG7xF0sk4TLd8K3zOqoubQfEkwKzXvohQ3pTUVOv/8zu+8u1yIFM8bGVS2gLHnVdbWDjVJrdl5nxADk1KAgihAGasHVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714163; c=relaxed/simple;
	bh=sJSiva4PddwBfMrwPmzSlfDqTFsy8rGG5TDmnFbMTuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZifCUDrOk7P+Cpxyel49fx6rB1YC5VF7+jNuV8n24DBcmVe2HZyDYQzP6fmvq5HxX7XiCSyFNNe4JHawstOocjkFMpHbz6moroA5Sq+o+hjK0KDe0cw10D4+wHjardEPEgfPyyvRTHTY4ymM9xJM57/etlZYqkLv50yZyzyVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b96c6fb262a911f0b29709d653e92f7d-20250717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:25a5aa73-3931-4967-b5cc-1afc07364d3c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:caa636b440508cb56c703d406c2f988f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b96c6fb262a911f0b29709d653e92f7d-20250717
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 685857645; Thu, 17 Jul 2025 09:02:34 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 9B23EE008FA3;
	Thu, 17 Jul 2025 09:02:34 +0800 (CST)
X-ns-mid: postfix-68784BAA-51963666
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id BA957E008FA2;
	Thu, 17 Jul 2025 09:02:32 +0800 (CST)
Message-ID: <a664f801-7faf-4a9f-b4b8-365afe0c6f5d@kylinos.cn>
Date: Thu, 17 Jul 2025 09:02:32 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] PM / Freezer: Skip zombie/dead processes to reduce
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
 <CAJZ5v0goQ0DcsWAqn__E7CG=YcNAzdxo9bb-21q50V2H5CJ+xA@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0goQ0DcsWAqn__E7CG=YcNAzdxo9bb-21q50V2H5CJ+xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

HI=C2=A0Rafael,

=E5=9C=A8 2025/7/16 20:26, Rafael J. Wysocki =E5=86=99=E9=81=93:
> Hi,
>
> On Wed, Jul 16, 2025 at 8:26=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylin=
os.cn> wrote:
>> Hi all,
>>
>> This patch series improves the performance of the process freezer by
>> skipping zombie tasks during freezing.
>>
>> In the suspend and hibernation paths, the freezer traverses all tasks
>> and attempts to freeze them. However, zombie tasks (EXIT_ZOMBIE with
>> PF_EXITING) are already dead =E2=80=94 they are not schedulable and ca=
nnot enter
>> the refrigerator. Attempting to freeze such tasks is redundant and
>> unnecessarily increases freezing time.
>>
>> In particular, on systems under fork storm conditions (e.g., many
>> short-lived processes quickly becoming zombies), the number of zombie =
tasks
>> can spike into the thousands or more. We observed that this causes the
>> freezer loop to waste significant time processing tasks that are guara=
nteed
>> to not need freezing.
> I think that the discussion with Peter regarding this has not been conc=
luded.
>
> I thought that there was an alternative patch proposed during that
> discussion.  If I'm not mistaken about this, what happened to that
> patch?
>
> Thanks!
>

Currently, the general consensus from the discussion is that skipping=20
zombie or dead tasks can help reduce locking overhead during freezing.=20
The remaining question is how best to implement that.

Peter suggested skipping all tasks with PF_NOFREEZE, which would make=20
the logic more general and cover all cases. However, as Oleg pointed=20
out, the current implementation based on PF_NOFREEZE might be problematic=
.

My current thought is that exit_state already reliably covers all=20
exiting user processes, and it=E2=80=99s a good fit for skipping user-spa=
ce=20
tasks. For the kernel side, we may safely skip a few kernel threads like=20
kthreadd that set PF_NOFREEZE and never change it =E2=80=94 we can consid=
er=20
refining this further in the future.


>> Testing and Results
>>
>> Platform:
>> - Architecture: x86_64
>> - CPU: ZHAOXIN KaiXian KX-7000
>> - RAM: 16 GB
>> - Kernel: v6.6.93
>>
>> result without the patch:
>> dmesg | grep elap
>> [  219.608992] Freezing user space processes completed (elapsed 0.010 =
seconds)
>> [  219.617355] Freezing remaining freezable tasks completed (elapsed 0=
.008 seconds)
>> [  228.029119] Freezing user space processes completed (elapsed 0.013 =
seconds)
>> [  228.040672] Freezing remaining freezable tasks completed (elapsed 0=
.011 seconds)
>> [  236.879065] Freezing user space processes completed (elapsed 0.020 =
seconds)
>> [  236.897976] Freezing remaining freezable tasks completed (elapsed 0=
.018 seconds)
>> [  246.276679] Freezing user space processes completed (elapsed 0.026 =
seconds)
>> [  246.298636] Freezing remaining freezable tasks completed (elapsed 0=
.021 seconds)
>> [  256.221504] Freezing user space processes completed (elapsed 0.030 =
seconds)
>> [  256.248955] Freezing remaining freezable tasks completed (elapsed 0=
.027 seconds)
>> [  266.674987] Freezing user space processes completed (elapsed 0.040 =
seconds)
>> [  266.709811] Freezing remaining freezable tasks completed (elapsed 0=
.034 seconds)
>> [  277.701679] Freezing user space processes completed (elapsed 0.046 =
seconds)
>> [  277.742048] Freezing remaining freezable tasks completed (elapsed 0=
.040 seconds)
>> [  289.246611] Freezing user space processes completed (elapsed 0.046 =
seconds)
>> [  289.290753] Freezing remaining freezable tasks completed (elapsed 0=
.044 seconds)
>> [  301.516854] Freezing user space processes completed (elapsed 0.041 =
seconds)
>> [  301.576287] Freezing remaining freezable tasks completed (elapsed 0=
.059 seconds)
>> [  314.422499] Freezing user space processes completed (elapsed 0.043 =
seconds)
>> [  314.465804] Freezing remaining freezable tasks completed (elapsed 0=
.043 seconds)
>>
>> result with the patch:
>> dmesg | grep elap
>> [   54.161674] Freezing user space processes completed (elapsed 0.007 =
seconds)
>> [   54.171536] Freezing remaining freezable tasks completed (elapsed 0=
.009 seconds)
>> [   62.556462] Freezing user space processes completed (elapsed 0.006 =
seconds)
>> [   62.566496] Freezing remaining freezable tasks completed (elapsed 0=
.010 seconds)
>> [   71.395421] Freezing user space processes completed (elapsed 0.009 =
seconds)
>> [   71.402820] Freezing remaining freezable tasks completed (elapsed 0=
.007 seconds)
>> [   80.785463] Freezing user space processes completed (elapsed 0.010 =
seconds)
>> [   80.793914] Freezing remaining freezable tasks completed (elapsed 0=
.008 seconds)
>> [   90.962659] Freezing user space processes completed (elapsed 0.012 =
seconds)
>> [   90.973519] Freezing remaining freezable tasks completed (elapsed 0=
.010 seconds)
>> [  101.435638] Freezing user space processes completed (elapsed 0.013 =
seconds)
>> [  101.449023] Freezing remaining freezable tasks completed (elapsed 0=
.013 seconds)
>> [  112.669786] Freezing user space processes completed (elapsed 0.015 =
seconds)
>> [  112.683540] Freezing remaining freezable tasks completed (elapsed 0=
.013 seconds)
>> [  124.585681] Freezing user space processes completed (elapsed 0.017 =
seconds)
>> [  124.599553] Freezing remaining freezable tasks completed (elapsed 0=
.013 seconds)
>> [  136.826635] Freezing user space processes completed (elapsed 0.016 =
seconds)
>> [  136.841840] Freezing remaining freezable tasks completed (elapsed 0=
.015 seconds)
>> [  149.686575] Freezing user space processes completed (elapsed 0.016 =
seconds)
>> [  149.701549] Freezing remaining freezable tasks completed (elapsed 0=
.014 seconds)
>>
>> Here is the user-space fork storm simulator used for testing:
>>
>> ```c
>> // create_zombie.c
>>
>> void usage(const char *prog) {
>>      fprintf(stderr, "Usage: %s <number_of_zombies>\n", prog);
>>      exit(EXIT_FAILURE);
>> }
>>
>> int main(int argc, char *argv[]) {
>>      if (argc !=3D 2) {
>>          usage(argv[0]);
>>      }
>>
>>      long num_zombies =3D strtol(argv[1], NULL, 10);
>>      if (num_zombies <=3D 0 || num_zombies > 1000000) {
>>          fprintf(stderr, "Invalid number of zombies: %ld\n", num_zombi=
es);
>>          exit(EXIT_FAILURE);
>>      }
>>
>>      printf("Creating %ld zombie processes...\n", num_zombies);
>>
>>      for (long i =3D 0; i < num_zombies; i++) {
>>          pid_t pid =3D fork();
>>          if (pid < 0) {
>>              perror("fork failed");
>>              exit(EXIT_FAILURE);
>>          } else if (pid =3D=3D 0) {
>>              // Child exits immediately
>>              exit(0);
>>          }
>>          // Parent does NOT wait, leaving zombie
>>      }
>>
>>      printf("All child processes created. Sleeping for 60 seconds...\n=
");
>>      sleep(60);
>>
>>      printf("Parent exiting, zombies will be reaped by init.\n");
>>      return 0;
>> }
>> ```
>>
>> And we used a shell loop to suspend repeatedly:
>>
>> ```bash
>> LOOPS=3D10
>>
>> echo none > /sys/power/pm_test
>> echo 5 > /sys/module/suspend/parameters/pm_test_delay
>> for ((i=3D1; i<=3DLOOPS; i++)); do
>> echo "=3D=3D=3D=3D=3D Test round $i/$LOOPS =3D=3D=3D=3D=3D"
>> ./create_zombie $((i * 3000)) &
>> sleep 5
>> echo mem > /sys/power/state
>>
>> pkill create_zombie
>> echo "Round $i complete. Waiting 5s..."
>> sleep 5
>>
>> done
>> echo "=3D=3D=3D=3D All $LOOPS rounds complete =3D=3D=3D=3D"
>> ```
>>
>> Zihuan Zhang (1):
>>    PM / Freezer: Skip zombie/dead processes to reduce freeze latency
>>
>>   kernel/power/process.c | 2 +-
>>   1 file changed, 9 insertion(+), 1 deletion(-)
>>
>> --
>> 2.25.1
>>

