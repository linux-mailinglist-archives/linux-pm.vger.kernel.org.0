Return-Path: <linux-pm+bounces-28814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB29ADAD74
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 12:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613997AA40F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F1327F72D;
	Mon, 16 Jun 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="hZEMnAZW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678AD2741B9;
	Mon, 16 Jun 2025 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069981; cv=none; b=ASVCJ4lTSVnR7o+T5UyNkJq19VJgCAsPqZip7hKqJHSNdgW3zDxBcpUjDpy1ckCoXeBHBwEBdzEM91LY3PsEaf8dvrw82US5BsS/XqqpNTrJEZl0XoY3hYwcU197ejhQ62TsKEb3hsBNR1xpzVhfyMrmavjjSuroJLeApeYMt4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069981; c=relaxed/simple;
	bh=zbYNG3njVAtH1dEsJCylZZ7mhn29KltrlG0PxCAQEX4=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=KfJrd2H/EtOHaXGaVfS8hoDCToOtvVUjF8fcD879RcogEd9SZTPjECYAmsc43Y29szJoJbtOhmgJNSBzmgrHX/BEnKCxgjoqHu2XrwKFN4RdEwi3FzbNYw08IMywJOERYDfDCF7K5HzDjP1yRpV4WWE+KnrnG/DY42KbDiTdOI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=hZEMnAZW; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1750069959; x=1750674759; i=frank-w@public-files.de;
	bh=zbYNG3njVAtH1dEsJCylZZ7mhn29KltrlG0PxCAQEX4=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hZEMnAZW/7mUOevdHKb5DW58hT1pv0jATDArPLJLr/bMpiQlhBtjWGcggVguBZIC
	 8bKreWfebe4JKxHucnkEJoHb+Y+f6VZhokMOi9bBfdoqkArsxnUOBoepBMfhBMAIN
	 EG0cAY68KIUipno2njp79/5AK70PJR5dirqfuaRVQ9sMMgiv1NMTtbjstL54iSyDE
	 uxJZabGCkQFe/wgkELZRA/iN4TYTUskglFymhOXcifousmL3UUH1QPR0h0pnEd6EF
	 jzcK7WaWDOv0syCGlM9sCAMY3moi4+LKX0SSA8rU/3TH4ie8gZO2NEMi1/juKlcLy
	 KDbTwkE+LB4dExakkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.67.37.206] ([100.67.37.206]) by
 trinity-msg-rest-gmx-gmx-live-b647dc579-4qvpp (via HTTP); Mon, 16 Jun 2025
 10:32:39 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-137d83ca-9fe9-4bc3-8482-ddaac9077b0d-1750069959310@trinity-msg-rest-gmx-gmx-live-b647dc579-4qvpp>
From: Frank Wunderlich <frank-w@public-files.de>
To: robh@kernel.org, krzk+dt@kernel.org, lorenzo@kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 angelogioacchino.delregno@collabora.com, linux@fw-web.de,
 frank-w@public-files.de
Subject: Aw: [PATCH v4 01/13] dt-bindings: net: mediatek,net: update for
 mt7988
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Jun 2025 10:32:39 +0000
In-Reply-To: <20250616095828.160900-2-linux@fw-web.de>
References: <20250616095828.160900-1-linux@fw-web.de>
 <20250616095828.160900-2-linux@fw-web.de>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:+PsAnRdYyRCcfuZ2aEIpeS3SraFNWACiWUPVZYdvuwi0fRlgjDTUG7NvRhmFPpU/PlGQH
 dNyNcklHMTkuXYr8XJh8tnSgdBzJJxsP97ipbekVAmzMHwLit/DoXqHvswlgmM8vY68NDpsdRFnz
 JZ43nEv+mjbp9r8pzElylUKBIayKmn7DDvtZFUEkBUUiOpmGzVc+xz6i6dCatSZhG8ngMqhptyCv
 PwzVg8qBXpdER0VlWJGyLWCd32Mx5/UN0VZD7/oMg/Ds52L9LDgEzwQRPYYu/dQJ9Tdzl9qoZCl4
 JuDd5aCHCZjc8rdsPA5ReRt77vgnj1w9JUjnQG9WDxxyjrrEpLDoZvti9XhWeRPwHw=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tTrr5nZYwHw=;IXSYPgh53TyZcIkZciMzpWDlETX
 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
 nlSOZp
Content-Transfer-Encoding: quoted-printable

Hi Rob, Krzysztof and Lorenzo,

I got message from your mailserver, that my patch-mails are detected as Sp=
am and blocked (to=20
other address than i used - seems like forwarding from kernel.org to gmail=
.com). I want to make
sure, you get it...

I see it in dt-bindings patchwork, so replacing the content with a link.

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250616095=
828.160900-2-linux@fw-web.de/

only kept angelo, me and ML in this response to not spam people too much.

regards Frank

