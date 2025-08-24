Return-Path: <linux-pm+bounces-32956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307ADB331AC
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 19:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4E93BB105
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35421FF47;
	Sun, 24 Aug 2025 17:50:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84A12C544;
	Sun, 24 Aug 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057816; cv=none; b=ZetXUVrW0hLZdpnpymOPSAISKKwVgoPqu4dF9cTEN0tw5uVHwWxxUPVuiAh/S6a3EavflwOdhK5Crmx1PwzaZtAmuEd+E7ovNfcSX+OVccPoUidnSvUumLaKoCAIYp2eJ3SuLqN6W+/Nj3NARRDgzjbsf0Zx2ytMTO7RCYnY5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057816; c=relaxed/simple;
	bh=biDVE5/qno9s6nbF5VWCCOnmRGqqbXzsItUeBwohWvE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DXhiz9u/q4Qi1097LovSOWL52c++kBAM0JH77D609ojzXhQV2fmnZo2SdMZoj9cI8jDmk1dlPbQI36vOzagbsVPx2Nofqt5QBpMiRzYIM1ZcDghW73iTtlTWIER7Mf0ObbgIRlPao7FCePb3cdLc7gdQnZSXl9b29/FP1E4Aiuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id D9C7F1DB206;
	Sun, 24 Aug 2025 17:50:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 020C817;
	Sun, 24 Aug 2025 17:50:05 +0000 (UTC)
Message-ID: <433518d6bc8ef4e5b4fc04e3343c13eddfc32e24.camel@perches.com>
Subject: Re: [PATCH] cpuidle: sysfs: fix coding style issue
From: Joe Perches <joe@perches.com>
To: vivekyadav1207731111@gmail.com, daniel.lezcano@linaro.org, 
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date: Sun, 24 Aug 2025 10:50:04 -0700
In-Reply-To: <20250824171543.17662-1-vivekyadav1207731111@gmail.com>
References: <20250824171543.17662-1-vivekyadav1207731111@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 020C817
X-Stat-Signature: 466a9c36ehho4ouiazhab43rzzwcmfdz
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+IAh9eO3KOkhpflMqq+I8VUv1T5wBf9yo=
X-HE-Tag: 1756057805-633099
X-HE-Meta: U2FsdGVkX19maFNFBCq1pwB/ZfFet2/QE6o3GjZA18R0TmOWsiElfTFrV+h2u3GiRbBsULLf289vhW8POZcU/eJI0bVGe+tZ+SmGgvIyywRfUoFecRU/bZWhkS0vgB/2VSM5qgJ6YgoDKQwD52MwQwT+peJX6KZzHOCK4/DcHmHd5FxeJWDk11gohJ+sPou6gAkevGQTtWLlqs6dP17epvGJWN2FAxSXsHD55rJbnAx90w3JJknPUow5W8o7WDf7UgOA/NXzFJKs3AfuqB6E9qnA6iJpwh37rtr+crWWQgtJPNFga88/BfYdCpWsJu7VWJh6yzLz7+fI9dxWRkAvx30aP5CE7AXx

On Sun, 2025-08-24 at 10:15 -0700, vivekyadav1207731111@gmail.com wrote:
> From: Vivek Yadav <vivekyadav1207731111@gmail.com>
>=20
> Fix a checkpatch.pl error by adding space around '+=3D'
> operator.
>=20
> No functional changes intended.
>=20
> [checkpatch.pl output]
> 	ERROR: spaces required around that '+=3D'

Perhaps better to convert all sprintf style uses
to sysfs_emit and sysfs_emit_at

> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
[]
> @@ -34,7 +34,7 @@ static ssize_t show_available_governors(struct device *=
dev,
>  	}
>=20
>  out:
> -	i+=3D sprintf(&buf[i], "\n");
> +	i +=3D sprintf(&buf[i], "\n");
>  	mutex_unlock(&cpuidle_lock);
>  	return i;
>  }

Something akin to:
---
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index d6f5da61cb7d8..3adb98c9986fd 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -22,21 +22,19 @@ static ssize_t show_available_governors(struct device *=
dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	ssize_t i =3D 0;
+	ssize_t len =3D 0;
 	struct cpuidle_governor *tmp;
=20
 	mutex_lock(&cpuidle_lock);
-	list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
-		if (i >=3D (ssize_t) (PAGE_SIZE - (CPUIDLE_NAME_LEN + 2)))
-			goto out;
=20
-		i +=3D scnprintf(&buf[i], CPUIDLE_NAME_LEN + 1, "%s ", tmp->name);
-	}
+	list_for_each_entry(tmp, &cpuidle_governors, governor_list)
+		len +=3D sysfs_emit_at(buf, len, "%s%s",
+				     len > 0 ? " " : "", tmp->name);
+	len +=3D sysfs_emit_at(buf, len, "\n");
=20
-out:
-	i+=3D sprintf(&buf[i], "\n");
 	mutex_unlock(&cpuidle_lock);
-	return i;
+
+	return len;
 }
=20
 static ssize_t show_current_driver(struct device *dev,
---
etc...

