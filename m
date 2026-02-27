Return-Path: <linux-pm+bounces-43287-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCwBAOZEoWkirwQAu9opvQ
	(envelope-from <linux-pm+bounces-43287-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:16:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 939951B3BC7
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB55431412AE
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 07:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9995B387591;
	Fri, 27 Feb 2026 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CkxkEXLi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EE03644D2
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176516; cv=none; b=uOW1oIU1BZ2DSgHFAn960DnW8EWXZeVa49FKofj/PgJ+yQ4FhwXcL/cxKmKenY2XG4a4//ltGlTGNDWMiCDZfnUaaAwqIE1oIfeV2ACMu0dRRNIJ4U9Iz+O53crcsRT+q8qMo9ha5D2kB/gjgug2Vp7O8veFyTlDFY7K4PmDyn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176516; c=relaxed/simple;
	bh=wYi6aEFxaLqRH1kvID/rgCJp6pAPIM8UPMfwfiqMHiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6Vm6364cPjgVi9CrXMVv0j7Z90Wea5yFDd10q6skdun73nzI6x1cySMFk7H9EC4EIXNqECFLlvjQ2muk5wlT3Qr4yWu+WE7fXCV4RUAQLiEnU9wibmGITyVvvXTc/HzOWGyMuZwBu8b0HVQsR+r/sy8bB4kEhnPJfc8/7noY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CkxkEXLi; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b93698bb57aso209190766b.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 23:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772176513; x=1772781313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2F5zLIEaaTfnN0o0tOAwvcRtoPgGDxKclbiaC7adGw=;
        b=CkxkEXLiRlo9wXZ3FRRVttkwWtrtLmkQdfRZ3WXDAcTyF/hrx/1fvAtsBN4SbHIpKO
         rE4fpdrsSQx88/nu93xja0d8EMzzFTmDq9uFj23vRP69anHdLjLedEcnA0GQ04HWSD4N
         63A/esQNMyr/lnPg/cXNQSNpmTAw3QDLRj3/OQ6FXnLRAiHpfkeQAUPCXxy38/NgjV1K
         MEzzAbaPAByfBVWZXjb/hqq4gEywkk7JDO3J8jDQbb3b34oxZOLEjwZ3vfFGxBmu03ve
         vHK0FeogP1I2IdLzSINSxz3qaD6HGZsORMJ+Hs4+XNqUU51epa1uD7qfbmRBhA5tinVg
         WaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772176513; x=1772781313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q2F5zLIEaaTfnN0o0tOAwvcRtoPgGDxKclbiaC7adGw=;
        b=sVRzTeFJ4te4Ido8XFHmWjDNvJ+wwa216LKpDz5ZBrUzpmYUc+PUpiq2G3uVUSYUEC
         hRT4HwpcbpYSXbNfRy25uevpnESMNazJnx3gU4o6lZs/6hh137T/fcLjUGIqZDDWvvki
         Leo/LKgqj3YMptUP+f8Wga/gUF6Mvsod85tGQjGlgpMrRuMbVXZPyVSFUqhUZOqP1Tpb
         +cb+GqbrEFCe+f/4TGIejaNA0/P6YwM7JXk6GMP5xL3yFTQHRlBt/kHENxMAUQkSsWer
         a7GUPklONPWJK5uLCq9dIIW6rqtDvhcmrT5ziplNEMXQTcat5ozeV/opXI+nj0G5BKUd
         9LcA==
X-Forwarded-Encrypted: i=1; AJvYcCWl29JAI/28HXczvvA1FIWmTkPa05ukxeya5tUd+Pv8DCm5pX+FSeLvzSWZwRXEIOCppFimCHsWwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRksqQC5C+f0s9iZlje3ff9OjEDAGP/+kX1h8LfGuyWRgl9kjD
	mEBYD01bIE8DFiAgQZnWDl3cK1QLZ1MImzoJMaDK9vQBknVWJVMSMssa1Y1wSmue274=
X-Gm-Gg: ATEYQzyT/Tb3IH8Vf70NSkUznAePrkILeGTFQcwT5ulR5JwNojROkGztyyzfzRek3/o
	xxCb2wWF4alUz4Y1UqDI+FlYEOyaDTzaRe54V+J6+CTt/pNTnSFWqII/JOd4IQeuidNdmtGlBJv
	79gBiYcXcNRaKESfG1DUPn6YhKveQrUmopeW7uq6kdnE4Gke6Dtj7x9INpA4+3/psS543kMJOr5
	lgArTpSDwl9lAkMkGh/VAFr+SBED4KlMGCEQeOAhLvmnJHIkZbsP8j7Q8FiyKWj6gXBvwb/0BDM
	ybWCC2QIW7w8kXctbWajZopg6DZrBnonLt+hTgHnz6CBwWnUKxvFsf7nPJZ25t8wFi8cZy1NsVd
	K11ud7rK505qxhhJB4eiJ5CgnQ7DCXOv7JKtG4ORC/GkZbjnMwYo3CgpoIdTxeQUEa2oKbBe4yu
	OUPFo49Q7ok39CIPiX2iqaWX0tjyGoTPfV98mbc28oUB5beWF1rOFz7YQWiIWbCEV/M1qQrWeT+
	3k5/AZRY3atOogtiAuPeFdndOQb
X-Received: by 2002:a17:906:eec2:b0:b87:31d1:4133 with SMTP id a640c23a62f3a-b937596b79amr86272566b.25.1772176513052;
        Thu, 26 Feb 2026 23:15:13 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aeee867sm124205066b.66.2026.02.26.23.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:15:12 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Feb 2026 07:15:12 +0000
Subject: [PATCH v2 07/11] power: supply: max17042: time to empty is
 meaningless when charging
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-max77759-fg-v2-7-e50be5f191f0@linaro.org>
References: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org>
In-Reply-To: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43287-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 939951B3BC7
X-Rspamd-Action: no action

When charging, the fuel gauge reports U16_MAX as time to empty.
Ignoring this special case (as this driver currently does), causes the
remaining time to be reported as ~102hours, which is incorrect.

Update the code to not return anything in this case.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max17042_battery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 8808c0d2ad10..bae0670e2496 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -434,6 +434,10 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
+		/* when charging, the value is not meaningful */
+		if (data == U16_MAX)
+			return -ENODATA;
+
 		val->intval = data * 5625 / 1000;
 		break;
 	default:

-- 
2.53.0.473.g4a7958ca14-goog


