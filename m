Return-Path: <linux-pm+bounces-11683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A12999417F4
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 18:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5668B1F2469E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E8190041;
	Tue, 30 Jul 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fdo6MlLH"
X-Original-To: linux-pm@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-76.smtpout.orange.fr [80.12.242.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81818E05B;
	Tue, 30 Jul 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356109; cv=none; b=GT3FDpm+CEKX5mIZLLBU6VhEXUqbRrEyWwM/H9CxpaPLVxy8qSfQi7UnEZbk5d6gUMKlvG/oCf4GcJuaszwOii0M1zDIG4fUTaA8mApr+kZ/cQHFQU3g6Q0G5BMbXEbqPUtQHsw9TXKdn789HLtimYNiFNXX4FlaR31paHKGVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356109; c=relaxed/simple;
	bh=U3QezZ/9wLTpiMytSi3mde8e/Rpz1z+6n85JpdNsLmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3i3NpOul5p6VfFfG1iRrTVon1C/UH31/oFYatDgLdFOOP0EM4ZH+N3RsdYyqp2Z5QeRtcQ4dQ+PZH/uMkBx6XgfpX0gi+JM/1YH0wzc4xtx9Pby1Uu0qxPgD3gix+L2h5WHqMeB8LYR5E0yrJiztr+InLXlqJByp/EXgZvhO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fdo6MlLH; arc=none smtp.client-ip=80.12.242.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id YpU0sUBCQk1NHYpU0sP4HH; Tue, 30 Jul 2024 18:13:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722356035;
	bh=3tCIQaWxilVkn/dJTsZpd50Op2owwp++CqpwU8TwuPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=fdo6MlLHu85cEcoMZ2uiANcnCGmV+TzzgTJ4zTxCZ4zf30nGsxwiWDTK8qcfeJfjE
	 jKbGSxZHceNV4EW/JXKtGItBFMS5MHrbig3qg7Hhdz17QLIZ72PBXEquL4PRiLr1z+
	 Xlo+akORH42h+yLJ8plujsHO7z5zuTW4BYpCidzEURc1hYzYnzZsrZyAasVt50eMWc
	 jLKF4mbV0RUlN6SsdJiwIeMVY24IZEG4KzNLzhegMxFD8xvcMcu8TbJus8rw6QvXq+
	 l6XxgGrwXF9k05eAqWg8Je1le6Xm2ssf4dJthncJErSgvSlYU+auGroz6Xncw2B7Dz
	 JdDWa5K3Lrh7g==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 30 Jul 2024 18:13:55 +0200
X-ME-IP: 90.11.132.44
Message-ID: <f82860ef-71d4-42af-807a-94e33f58d769@wanadoo.fr>
Date: Tue, 30 Jul 2024 18:13:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] PM: hibernate: Use sysfs_emit() and
 sysfs_emit_at() in "show" functions
To: Xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org, pavel@ucw.cz,
 len.brown@intel.com
Cc: linux-pm@vger.kernel.org, xiongxin@kylinos.cn,
 linux-kernel@vger.kernel.org
References: <20240730065454.2096296-1-luoxueqin@kylinos.cn>
 <20240730065454.2096296-2-luoxueqin@kylinos.cn>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240730065454.2096296-2-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 30/07/2024 à 08:54, Xueqin Luo a écrit :
> As Documentation/filesystems/sysfs.rst suggested,
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> No functional change intended.
> 
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---

Hi,
...

> @@ -1210,7 +1210,7 @@ power_attr(disk);
>   static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
>   			   char *buf)
>   {
> -	return sprintf(buf, "%d:%d\n", MAJOR(swsusp_resume_device),
> +	return sysfs_emit(buf, "%d:%d\n", MAJOR(swsusp_resume_device),
>   		       MINOR(swsusp_resume_device));

Nitpick: now the alignment with the '(' is not correct anymore.

>   }
>   

...

CJ


