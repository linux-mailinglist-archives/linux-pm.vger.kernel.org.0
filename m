Return-Path: <linux-pm+bounces-30892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA1DB06DE6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 08:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630E73A6DD1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 06:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3762877CD;
	Wed, 16 Jul 2025 06:26:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDB5269817;
	Wed, 16 Jul 2025 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647218; cv=none; b=RI+y5pENx8gR9NTsqiffNn1iXQ8FtGAdB12qXD6QMVlsFJud0Kt7sywQKWnPsnuFuZq+r7cOIAbz2c60aRzSCPQAvRN3iMMr25C0eYm1eJ860ngXE253fplNBHTmasgei8u+wtJYystX1P5xcqEqENgvD7NEGJksf2ErwIczA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647218; c=relaxed/simple;
	bh=G2Qj8+5Ot4GgvzeFLvEvi08E18R5HeOiUHk4IHpB1DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nGibDIifcRIGEqcB7NV/GTield3Q5H5RaLN8QlhDtSrAWpReVSWRYROtkuKCbsFeeUy4AYvBLCrH+C9VJ6H1sd9+b0DKw6a59bqc8LXGCa6QoOvEiae88d/GKuCXpGk8YuDrB+ewzBpjssvx4pecOgrw02vsTHdhjxarmG8YwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d8fb0f10620d11f0b29709d653e92f7d-20250716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d33a5053-fb8d-43ad-881f-8d7830f07dd2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:cc247a93668082533e88b9fedfca021a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d8fb0f10620d11f0b29709d653e92f7d-20250716
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1548868100; Wed, 16 Jul 2025 14:26:46 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 059EFE008FA3;
	Wed, 16 Jul 2025 14:26:46 +0800 (CST)
X-ns-mid: postfix-68774625-875499186
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 96497E008FA2;
	Wed, 16 Jul 2025 14:26:44 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	len brown <len.brown@intel.com>,
	pavel machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v4 0/1] PM / Freezer: Skip zombie/dead processes to reduce
Date: Wed, 16 Jul 2025 14:26:38 +0800
Message-Id: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

This patch series improves the performance of the process freezer by
skipping zombie tasks during freezing.

In the suspend and hibernation paths, the freezer traverses all tasks
and attempts to freeze them. However, zombie tasks (EXIT_ZOMBIE with
PF_EXITING) are already dead =E2=80=94 they are not schedulable and canno=
t enter
the refrigerator. Attempting to freeze such tasks is redundant and
unnecessarily increases freezing time.

In particular, on systems under fork storm conditions (e.g., many
short-lived processes quickly becoming zombies), the number of zombie tas=
ks
can spike into the thousands or more. We observed that this causes the
freezer loop to waste significant time processing tasks that are guarante=
ed
to not need freezing.

Testing and Results

Platform:
- Architecture: x86_64
- CPU: ZHAOXIN KaiXian KX-7000
- RAM: 16 GB
- Kernel: v6.6.93

result without the patch:
dmesg | grep elap
[  219.608992] Freezing user space processes completed (elapsed 0.010 sec=
onds)
[  219.617355] Freezing remaining freezable tasks completed (elapsed 0.00=
8 seconds)
[  228.029119] Freezing user space processes completed (elapsed 0.013 sec=
onds)
[  228.040672] Freezing remaining freezable tasks completed (elapsed 0.01=
1 seconds)
[  236.879065] Freezing user space processes completed (elapsed 0.020 sec=
onds)
[  236.897976] Freezing remaining freezable tasks completed (elapsed 0.01=
8 seconds)
[  246.276679] Freezing user space processes completed (elapsed 0.026 sec=
onds)
[  246.298636] Freezing remaining freezable tasks completed (elapsed 0.02=
1 seconds)
[  256.221504] Freezing user space processes completed (elapsed 0.030 sec=
onds)
[  256.248955] Freezing remaining freezable tasks completed (elapsed 0.02=
7 seconds)
[  266.674987] Freezing user space processes completed (elapsed 0.040 sec=
onds)
[  266.709811] Freezing remaining freezable tasks completed (elapsed 0.03=
4 seconds)
[  277.701679] Freezing user space processes completed (elapsed 0.046 sec=
onds)
[  277.742048] Freezing remaining freezable tasks completed (elapsed 0.04=
0 seconds)
[  289.246611] Freezing user space processes completed (elapsed 0.046 sec=
onds)
[  289.290753] Freezing remaining freezable tasks completed (elapsed 0.04=
4 seconds)
[  301.516854] Freezing user space processes completed (elapsed 0.041 sec=
onds)
[  301.576287] Freezing remaining freezable tasks completed (elapsed 0.05=
9 seconds)
[  314.422499] Freezing user space processes completed (elapsed 0.043 sec=
onds)
[  314.465804] Freezing remaining freezable tasks completed (elapsed 0.04=
3 seconds)

result with the patch:
dmesg | grep elap
[   54.161674] Freezing user space processes completed (elapsed 0.007 sec=
onds)
[   54.171536] Freezing remaining freezable tasks completed (elapsed 0.00=
9 seconds)
[   62.556462] Freezing user space processes completed (elapsed 0.006 sec=
onds)
[   62.566496] Freezing remaining freezable tasks completed (elapsed 0.01=
0 seconds)
[   71.395421] Freezing user space processes completed (elapsed 0.009 sec=
onds)
[   71.402820] Freezing remaining freezable tasks completed (elapsed 0.00=
7 seconds)
[   80.785463] Freezing user space processes completed (elapsed 0.010 sec=
onds)
[   80.793914] Freezing remaining freezable tasks completed (elapsed 0.00=
8 seconds)
[   90.962659] Freezing user space processes completed (elapsed 0.012 sec=
onds)
[   90.973519] Freezing remaining freezable tasks completed (elapsed 0.01=
0 seconds)
[  101.435638] Freezing user space processes completed (elapsed 0.013 sec=
onds)
[  101.449023] Freezing remaining freezable tasks completed (elapsed 0.01=
3 seconds)
[  112.669786] Freezing user space processes completed (elapsed 0.015 sec=
onds)
[  112.683540] Freezing remaining freezable tasks completed (elapsed 0.01=
3 seconds)
[  124.585681] Freezing user space processes completed (elapsed 0.017 sec=
onds)
[  124.599553] Freezing remaining freezable tasks completed (elapsed 0.01=
3 seconds)
[  136.826635] Freezing user space processes completed (elapsed 0.016 sec=
onds)
[  136.841840] Freezing remaining freezable tasks completed (elapsed 0.01=
5 seconds)
[  149.686575] Freezing user space processes completed (elapsed 0.016 sec=
onds)
[  149.701549] Freezing remaining freezable tasks completed (elapsed 0.01=
4 seconds)

Here is the user-space fork storm simulator used for testing:

```c
// create_zombie.c

void usage(const char *prog) {
    fprintf(stderr, "Usage: %s <number_of_zombies>\n", prog);
    exit(EXIT_FAILURE);
}

int main(int argc, char *argv[]) {
    if (argc !=3D 2) {
        usage(argv[0]);
    }

    long num_zombies =3D strtol(argv[1], NULL, 10);
    if (num_zombies <=3D 0 || num_zombies > 1000000) {
        fprintf(stderr, "Invalid number of zombies: %ld\n", num_zombies);
        exit(EXIT_FAILURE);
    }

    printf("Creating %ld zombie processes...\n", num_zombies);

    for (long i =3D 0; i < num_zombies; i++) {
        pid_t pid =3D fork();
        if (pid < 0) {
            perror("fork failed");
            exit(EXIT_FAILURE);
        } else if (pid =3D=3D 0) {
            // Child exits immediately
            exit(0);
        }
        // Parent does NOT wait, leaving zombie
    }

    printf("All child processes created. Sleeping for 60 seconds...\n");
    sleep(60);

    printf("Parent exiting, zombies will be reaped by init.\n");
    return 0;
}
```

And we used a shell loop to suspend repeatedly:

```bash
LOOPS=3D10

echo none > /sys/power/pm_test
echo 5 > /sys/module/suspend/parameters/pm_test_delay
for ((i=3D1; i<=3DLOOPS; i++)); do
echo "=3D=3D=3D=3D=3D Test round $i/$LOOPS =3D=3D=3D=3D=3D"
./create_zombie $((i * 3000)) &
sleep 5
echo mem > /sys/power/state

pkill create_zombie
echo "Round $i complete. Waiting 5s..."
sleep 5

done
echo "=3D=3D=3D=3D All $LOOPS rounds complete =3D=3D=3D=3D"
```

Zihuan Zhang (1):
  PM / Freezer: Skip zombie/dead processes to reduce freeze latency

 kernel/power/process.c | 2 +-
 1 file changed, 9 insertion(+), 1 deletion(-)

--=20
2.25.1


