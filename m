Return-Path: <linux-pm+bounces-42398-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RmyUDX3SimmxOAAAu9opvQ
	(envelope-from <linux-pm+bounces-42398-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 07:38:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA98E11767F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 07:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C5F6300C315
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 06:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D9232E68F;
	Tue, 10 Feb 2026 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPaMhkZc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CECE32D0EA
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705530; cv=none; b=uBpQR9XhzTikzLBbhJAM5k38w5s2zIha6lorm32EEqyUegOmohgTVPTB2BMWHWjY4LM3c1+LW512kGlyicHn9wc0Ex//AvVpYW+b+D0ClNGO77r+6J3K3kq/YFukA3SFOFd+5hXcTDtJxVyYUeFCqneK403h/rNun7fB2jbWkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705530; c=relaxed/simple;
	bh=Tzvqbf/lzUX+Xryn3wOPmUQNw3pnqvGuG9huSDJZPn4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b6ZyuIdcVymsBxjnEqkIEfO5IxpIR0PsWyCwi1ZTIvYGM6M3CJ0+8jJdoD0RiKFutsr3SfUI/Ql7bSMnFf1KbYww6kAYaeRBHSNPRTw4PHj825j+E/pSNG4oPzhg0AhW6pdA4geZar2YqeJrM1mvzkjRnn7Lap6JiSX7iqWU6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aPaMhkZc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so49449085e9.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 22:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770705528; x=1771310328; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lLdYDGt/+DrOZdYJB2wqY0IBiaBFC8iK50DATmXPJZs=;
        b=aPaMhkZcfXpmP2tm/iJaq/CWcrBT5oUwIPYKVQunfq07wAHYn5QH79di58LjJZCCKZ
         ElWls/ygW5HHWkNDwOfos/MTuCMj6r8QfeKoK5qeFFRXQZE0Jzb5MgWfuIQtwbB7SgTI
         t0w/NgrN4Qvdqu4Ro03urdFF/zw5By8GRlEd50bbXeMHCJ6oVqTrqwaUwvztZSeCzJcn
         3+NfnuTuWPqRVUpRVvW5khABjNpmtMnLrM/nhazeMNrk05OgjuO1/R8+Jr+2tBrXsHtU
         wndcURxtIj4wsyMcBnt+G1R2Pj/3iRi9vELwS8GP9yQLL/vDhAW/ntof0pq3Aw01JPGf
         JTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770705528; x=1771310328;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLdYDGt/+DrOZdYJB2wqY0IBiaBFC8iK50DATmXPJZs=;
        b=qnqxuljhj/Xlih3QSnMWj/jWSZfKZIgfzAEwj3ET1mxTRFWdm1e8d9+hS6tYb4v8ti
         LHGckSi4x7WpHS3YUR8iBSq4TG85q2vpgJhjnMEucFgHs9Yl+M59iUPK3HaeacaUcdNd
         YiDdXWAFGSZQvFJSK9YgXWD7jAMBCgBrBtJ6Njwc8WAYvXnrga2xbjZh8osrc2PXZKsR
         Pnym8qBhY4l7EAPn2SNvNf5hmMN+q2ypPu/1E/bPgOqnRvIrSP1blx+PNXvAEv/++fn8
         TuBT9xr2M+p4aa08KbF43xffSFhs+1k64jORzwZm8EdnoKRXZNhhOy0FP22GDSp+m3Uh
         BAXw==
X-Forwarded-Encrypted: i=1; AJvYcCXHp+yrirh3MaT9IS8PAptbqp7oIZtrNRES36LOlpmf1XL8kL568K3i2hM7aZ5zJuy+ucYSmGmb2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyij8D3Q6OyBlm0B4UxgPt27yq1ChPbKxcAIV1JCN4bsoJ/XWU/
	vC2ff26mM892e0Nhm7kc/cyDvPxnKwrIYooOwwXEw//p4oHxoxF3TzIaoUsvYusvCfg=
X-Gm-Gg: AZuq6aIHnlc70jy52t0mZn3EBMkeunQ0eytBYpDJc+FKeJWL/ur76cD2S1U8u0PT3vd
	XjF9hpy046V/IbwhB1ogZe+lS95asfTPFKMKF4YjkKlmPxATMQT4kYJw+0VJ2gM9YUQTbBlUS+l
	HaO6XaU7V47kzhT5dktF/yu/UodR8PWc/HPV6REwe8viy6bSlEunRc6umjmug/PB6klu4Lz07r5
	IN1WxITkuFT7fmCRBDct1khjfBZYq2XsE2psYMs6WkChiNXRFsyBCCI8cT/FXu6ooOeSA4Mkvtk
	fBo/Kn992/iKA79e9U098P5CucC7v3QBEfMx29nCbtiQGi3gLWvRSQ6BcD1azLjZV9mR+gzWoFL
	24qUQrUWZAWmtruZJeMoVxtZYSVu+0NfbAjjXsTc9WtUhgdVZWtXdA+A8N0VqtyX7b6y8TUfsrL
	OW9yXeLt4+MIMQ1KNIy35m2A9gdSB8aA==
X-Received: by 2002:a05:600c:c086:b0:47e:e7de:7c41 with SMTP id 5b1f17b1804b1-4834ffb08f0mr12556465e9.16.1770705527668;
        Mon, 09 Feb 2026 22:38:47 -0800 (PST)
Received: from draszik.lan ([212.129.79.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d8334a8sm37397915e9.12.2026.02.09.22.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 22:38:47 -0800 (PST)
Message-ID: <9fce298c842533bc6ede7f1a97040337236351d8.camel@linaro.org>
Subject: Re: [PATCH v5 4/5] power: supply: max77759: add charger driver
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>, Sebastian Reichel
 <sre@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Lee Jones
 <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Badhri
 Jagan Sridharan	 <badhri@google.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>,  Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Alim
 Akhtar	 <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, RD
 Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Date: Tue, 10 Feb 2026 06:39:14 +0000
In-Reply-To: <277e1c95-e221-4c07-a00e-d0f0a1a7553f@google.com>
References: <20260203-max77759-charger-v5-0-b50395376a5f@google.com>
	 <20260203-max77759-charger-v5-4-b50395376a5f@google.com>
	 <3ab2d8cd112441dc1d7ab5097f5b1b64c7e415ab.camel@linaro.org>
	 <277e1c95-e221-4c07-a00e-d0f0a1a7553f@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42398-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: BA98E11767F
X-Rspamd-Action: no action

Hi Amit,

On Mon, 2026-02-09 at 16:42 -0800, Amit Sunil Dhamne wrote:
> Hi Andre',
>=20
> On 2/4/26 4:49 AM, Andr=C3=A9 Draszik wrote:
> > On Tue, 2026-02-03 at 22:50 +0000, Amit Sunil Dhamne via B4 Relay wrote=
:
> >=20
> > > +
> > > +static void psy_work_item(struct work_struct *work)
> > > +{
> > > +	struct max77759_charger *chg =3D
> > > +		container_of(work, struct max77759_charger, psy_work.work);
> > > +	union power_supply_propval current_limit, online;
> > > +	int ret;
> > > +
> > > +	ret =3D power_supply_get_property(chg->tcpm_psy,
> > > +					POWER_SUPPLY_PROP_CURRENT_MAX,
> > > +					&current_limit);
> > > +	if (ret) {
> > > +		dev_err(chg->dev,
> > > +			"Failed to get CURRENT_MAX psy property, ret=3D%d",
> > > +			ret);
> > > +		goto err;
> > > +	}
> > > +
> > > +	ret =3D power_supply_get_property(chg->tcpm_psy, POWER_SUPPLY_PROP_=
ONLINE,
> > > +					&online);
> > > +	if (ret) {
> > > +		dev_err(chg->dev,
> > > +			"Failed to get ONLINE psy property, ret=3D%d",
> > > +			ret);
> > > +		goto err;
> > > +	}
> > > +
> > > +	if (online.intval && current_limit.intval) {
> > > +		ret =3D set_input_current_limit(chg, current_limit.intval);
> > > +		if (ret) {
> > > +			dev_err(chg->dev,
> > > +				"Unable to set current limit, ret=3D%d", ret);
> > > +			goto err;
> > > +		}
> > > +
> > > +		charger_set_mode(chg, MAX77759_CHGR_MODE_CHG_BUCK_ON);
> > > +	} else {
> > > +		charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
> > > +	}
> > > +
> > > +	chg->psy_work_retry_cnt =3D 0;
> > > +	return;
> > > +
> > > +err:
> > > +	charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
> > > +	if (chg->psy_work_retry_cnt >=3D MAX_NUM_RETRIES)
> > > +		return;
> > I'd say this final giving up could benefit from a dev_err(), while ...
>=20
> I want to clarify if you want me to add this final giving up print just=
=20
> once or every time I am returning early?

I meant something along the lines of this:

+	if (chg->psy_work_retry_cnt)
+		dev_dbg(chg->dev, "chg psy_work succeeded after %d\n",
+			chg->psy_work_retry_cnt)
+	chg->psy_work_retry_cnt =3D 0;
+	return;
+
+err:
+	charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
+	if (chg->psy_work_retry_cnt >=3D MAX_NUM_RETRIES) {
+		dev_warn(chg->dev, "chg psy_work failed, giving up",
+			 chg->psy_work_retry_cnt, MAX_NUM_RETRIES);
+		return;
+	}

> >=20
> > > +
> > > +	++chg->psy_work_retry_cnt;
> > > +	dev_err(chg->dev, "Retrying %u/%u chg psy_work",
> > > +		chg->psy_work_retry_cnt, MAX_NUM_RETRIES);
> > ... this one could be demoted (but doesn't have to).
> >=20
> > That'd make it easier to determine if it's still in the process of
> > trying, or if it has given up fully.
>=20
> I was assuming the printing of "3/3" would indicate the final giving up=
=20
> and sufficient.


If you see 3/3 in the log, you'll know that it has scheduled the work (for
the last attempt), but you won't easily know if 3/3 has ran yet or if it
has completed successfully this time or if it was still unsuccessful.

> >=20
> > > +	schedule_delayed_work(&chg->psy_work,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msecs_to_jiffies(PSY_WORK_RETRY_DE=
LAY_MS));
> > > +}
> > > +
> > > +static int psy_changed(struct notifier_block *nb, unsigned long evt,=
 void *data)
> > > +{
> > > +	struct max77759_charger *chg =3D container_of(nb, struct max77759_c=
harger,
> > > +						=C2=A0=C2=A0=C2=A0 nb);
> > > +	static const char *psy_name =3D "tcpm-source";
> > > +	struct power_supply *psy =3D data;
> > > +
> > > +	if (!strnstr(psy->desc->name, psy_name, strlen(psy_name)) ||
> > > +	=C2=A0=C2=A0=C2=A0 evt !=3D PSY_EVENT_PROP_CHANGED)
> > > +		return NOTIFY_OK;
> > > +
> > > +	chg->tcpm_psy =3D psy;
> > Do you need locking here? What if this is changed while a previous
> > psy_work_item() is still executing?
>=20
> I=C2=A0 don't think that's ever possible in this case though. The power=
=20
> supply that this driver registers is downstream of the tcpm's.


A previous work could still be executing (e.g. due to retrying), no? It
should also probably set chg->psy_work_retry_cnt =3D 0; here, to allow it
to retry up to MAX_NUM_RETRIES when a new work is queued and a previous
one was unsuccessful?




Cheers,
Andre

