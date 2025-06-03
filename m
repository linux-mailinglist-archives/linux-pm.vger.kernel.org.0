Return-Path: <linux-pm+bounces-28031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC3ACCB2C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 18:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098833A89EB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 16:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142C2405FD;
	Tue,  3 Jun 2025 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="brLOcr94"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067A23816C;
	Tue,  3 Jun 2025 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967745; cv=none; b=rmSVjIkQwyu1hrfgaBe+XPem7gEO7kn7YfxKUH8mq+97HTkKFXYEok59beinwufhH5vLgMymsgcw9G6pMipx+DVINrNFU/ILHN9Tb+cpnMbfhv+Duwn2hDQAibjN6ZloqcxZesLv6CVwmkaBFZUuZ+pAfKzFWWuRWgCWbqlM/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967745; c=relaxed/simple;
	bh=z1mLVuRi1luWUi7b3DBh3hPswREC3ZZGIxtXhLAHNv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/KRhFRvc9XLMqKC00OL/ikZATngGGR506N4i618KP0/whigC9YT8WAd0Bgtq7wIyuUiBNLj9mAtqLPMdBsFskWbbNCOqyBzVASO1AkrprgNoq8zLfG/wlQL7QXnRcA71D1Db1IDUwdJKWTeVHhU35jZJ01vQEmUrs4Bt8T3S1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=brLOcr94; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 89A2366B47B;
	Tue,  3 Jun 2025 18:22:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1748967736;
	bh=z1mLVuRi1luWUi7b3DBh3hPswREC3ZZGIxtXhLAHNv4=;
	h=From:Subject:Date;
	b=brLOcr94BuI8KNY9PZ7yZFW4SgT6+dYHX+ZJAT2t+pAWbj5rIv38VifOpSKcWLPJb
	 2WESKwNow2v1BEnkGvjPzU7wloejd+ePGwpjV36rD852paw8/RBwOo6S01W+/QlCI9
	 KHdhVYTtCW2aPS+9vMBTl/6GcSYFir5ISvO/sfrwkAFy5HvSWmm9HTnTG0LeOTTIak
	 QP8MMV4g/GYQXJ9Yj/NNtYWfcxrnjSXRPsi7UUPKLj+glbxLKe5/c4uW+d81Pl50sm
	 cJX7+KNU/IJgoebGr2h2hlpy3aFgB6a+2xt3VWXPaSoiF0p7wDXpz8FaUYPaSdjqc1
	 fiFqYb+gOAH0Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Chris Bainbridge <chris.bainbridge@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject:
 [PATCH v1 1/3] PM: sleep: Fix list splicing in device suspend error paths
Date: Tue, 03 Jun 2025 18:17:58 +0200
Message-ID: <4659282.LvFx2qVVIh@rjwysocki.net>
In-Reply-To: <6166108.lOV4Wx5bFT@rjwysocki.net>
References: <6166108.lOV4Wx5bFT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTFuZted3QHr/rVwZgdGLcyqu8jkWWOxJF0GFW6Lugmgslew6ZhSn6h88vs1LdILcIVV787TfB6M6b+mRXT06Ij8EuvQrp10ceSLb3/icU7F9n15O3KV4ZWbfWiZyZe7lKp46Kt5G4w0X6iG/QLBydyoV2uRCEgOh90bRqimATdZBJrd4z2/yhBk8j0kFroKeRxFh+++6Pm0zYnNO+67Y9BGSZG8pvisrWIP2dzOYTeG279fZhoGPFisKCoIs30GzEgjHE59fQU50or0qxeX+C1Q5vZyPw5H15xoPkQA8KS8pUUPZfsVou8ma7mTKBCGEr3OAYmA5L+5ao/is7OI/SPCUB4Qi3SjayYvCVf95tSCKdbtEMrtVRcKCc93WyMbaDOT8ePm9epkUFx5jiZ/1M3rzZwVkic/7wY1dOgy8LYhna/Wd00+Xwp1voGTIcug/2LCCjSZIbfz/vOkkGCOJokzPJl7odjWbhGFQhhMTvfsbVv31k1z3Phlh57b/fJDKCj6C3LnHMhtCIvYWCVL+zsXZI1e2Ratg6uaON9d1Gy7ZTWXFyGpf+rGApsYl58LCpVQ5Gr9Hl1k9pyAtNqViMsrxG5GkRMmbO7CP+gbULx33bzGKKKoT0SbV5QTwTtP5vyiuP4jE1GQdOnt8XCLrG7fawcRqW+qk4mhvc8yQXp2BA
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commits aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending
children") and 443046d1ad66 ("PM: sleep: Make suspend of devices more
asynchronous") added list splicing to the error paths of dpm_suspend(),
dpm_suspend_late(), and dpm_noirq_suspend_devices(), but they should
have used the list_splice_init() variant because the emptied list is
used going forward in all of these cases.

Replace list_splice() with list_splice_init() in the code in question as
appropriate.

Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1458,7 +1458,7 @@
 			 * Move all devices to the target list to resume them
 			 * properly.
 			 */
-			list_splice(&dpm_late_early_list, &dpm_noirq_list);
+			list_splice_init(&dpm_late_early_list, &dpm_noirq_list);
 			break;
 		}
 	}
@@ -1660,7 +1660,7 @@
 			 * Move all devices to the target list to resume them
 			 * properly.
 			 */
-			list_splice(&dpm_suspended_list, &dpm_late_early_list);
+			list_splice_init(&dpm_suspended_list, &dpm_late_early_list);
 			break;
 		}
 	}
@@ -1953,7 +1953,7 @@
 			 * Move all devices to the target list to resume them
 			 * properly.
 			 */
-			list_splice(&dpm_prepared_list, &dpm_suspended_list);
+			list_splice_init(&dpm_prepared_list, &dpm_suspended_list);
 			break;
 		}
 	}




