Return-Path: <linux-pm+bounces-34925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 159F8B822A4
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 00:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAFF1C80F86
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 22:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0593130DED7;
	Wed, 17 Sep 2025 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="f1wkZLCF"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA92FB991;
	Wed, 17 Sep 2025 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148379; cv=pass; b=oWPOjiAj3+65zvFTA/Szitu44FgU0ypFARMQBOi6/8XpygKQCUZjkPt6Bo5o60jpB70F4EKxYQwcP34/ZceTkj7bNmMrPTijz55t1PIf4Ks9iTVU+coV4gzLixWQQokA5SK06DK3bBZuDxMETc7YZPioV1fh58Hkuf43kI8Ma4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148379; c=relaxed/simple;
	bh=znX0wfJrHVXZiPMAukCX4OIy8l6PjtgaOLRfY5RPUME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODLiw1xif8xhIqvAmdhYsB5ezz4GRKDXU7mLjhpQA+rrZGuxknjPzOiKdLK4dW1l6JWTqczagTUWDItNmtI5EppLdqDe4zecRIMO7TKkzfyi6IQymwFz26uO6ydlJB0yXmHgtW4fPxtSAocQnhgUImtLLxnrITLse6CzbGbQP3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=f1wkZLCF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758148355; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bCxyIqp89NV/9zp2f1W2doyMdsW5a/oS4lHZ6EeW7CIVSZJR3aIjv2fT5j5HFR8e+Et+ze+qKPlgEeI8dLsFenFbRliSQ7DUrQbxbm1gqtdlUvLn6kmtTB6O9ynP3CeL7eBdbmf1+GQ233o+OLAkNSoOYO4HxwihjbCUPtDUdY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758148355; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=znX0wfJrHVXZiPMAukCX4OIy8l6PjtgaOLRfY5RPUME=; 
	b=D4vjkZ13IGJMfMK1SzTSj2iqAyRlwmI8BPfBRAEf9du6ZXpwTx3GD8VlYyupTwad9Xtet9GvovcjsfLEeX/pjW/PVLpPlFgC+WvsH8WlrvaTLGVobapLof7wgFswAeGHaaiEHqkIdi+XzM0sjdfL3mcmM3dUVUsxxWhHI9JZYr4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758148354;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=znX0wfJrHVXZiPMAukCX4OIy8l6PjtgaOLRfY5RPUME=;
	b=f1wkZLCFtAO+8kdrY433OzA3P2THDnewPONSmGOqI3YoNAs84dlGmmgdtHy0XGy6
	fL/yaQn62HWHREgrRFovuT3orQmII9a8V+VEqJx8EqjsIVAjPgiip48sSZyrN9yUs3E
	CgSkItHQ3t+73NpUDSqDeITKX78KN6n7AnDUqOCw=
Received: by mx.zohomail.com with SMTPS id 1758148351679297.874876738947;
	Wed, 17 Sep 2025 15:32:31 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 9E3BF18067C; Thu, 18 Sep 2025 00:32:24 +0200 (CEST)
Date: Thu, 18 Sep 2025 00:32:24 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Vinod Koul <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, 
	Stephen Boyd <swboyd@chromium.org>, Andre Draszik <andre.draszik@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	Elliot Berman <quic_eberman@quicinc.com>, Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v14 02/10] power: reset: reboot-mode: Add device tree
 node-based registration
Message-ID: <wsig6dm7jbnx2pzt5l3uhhgywsa4jsdyunmd5aqn43bbciqiov@4y6mnd25pbeg>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
 <20250815-arm-psci-system_reset2-vendor-reboots-v14-2-37d29f59ac9a@oss.qualcomm.com>
 <in6bqvemnscvuxbumpxogxiiav7odmsc3iazktifninh6iqen7@qwhrhdidcx7y>
 <3c56cd00-770f-019a-d93b-5ebaa6b9374d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="luhwbfkc5nm4f2sl"
Content-Disposition: inline
In-Reply-To: <3c56cd00-770f-019a-d93b-5ebaa6b9374d@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.96.42
X-ZohoMailClient: External


--luhwbfkc5nm4f2sl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v14 02/10] power: reset: reboot-mode: Add device tree
 node-based registration
MIME-Version: 1.0

Hi,

On Wed, Sep 17, 2025 at 09:59:44PM +0530, Shivendra Pratap wrote:
> On 9/17/2025 12:18 AM, Sebastian Reichel wrote:
> > On Fri, Aug 15, 2025 at 08:05:07PM +0530, Shivendra Pratap wrote:
> >> The reboot-mode driver does not have a strict requirement for
> >> device-based registration. It primarily uses the device's of_node
> >> to read mode-<cmd> properties and the device pointer for logging.
> >>
> >> Remove the dependency on struct device and introduce support for
> >> Device Tree (DT) node-based registration. This enables drivers
> >> that are not associated with a struct device to leverage the
> >> reboot-mode framework.
> >>
> >> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> >> ---
> >=20
> > Please use fwnode instead of device_node, so that the same thing
> > can be used with non DT setups, if that becomes necessary. Otherwise
> > LGTM.
>=20
> To be more clear on this, have one question: the current unmodified
> design of reboot-mode is dt based:
>=20
> struct device_node *np =3D reboot->dev->of_node;
> and then parses the node using for_each_property_of_node(np, prop).
>=20
> We want to refactor reboot-mode to support non-DT setups by adding
> support for fwnode-based approach (struct fwnode_handle *fwnode)?
>=20
> Can you please explain a bit? Some more details would be helpful to
> make the change.

It's fine to keep using of_node internally. But the external API
(include/linux/reboot-mode.h) should use fwnode. Just like the
current external API is not DT specific as it just gets a struct
device. This keeps the external API somewhat ready for non-DT users
and avoids having to change all API users again in the future.

Greetings,

-- Sebastian

--luhwbfkc5nm4f2sl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjLNvEACgkQ2O7X88g7
+poQJA//S0EEioAN/VF4J/lYtmOcBv99Crrgs/3l9I46szqCWPOAqla+K3ns0A8U
3djWdGcDMNenrYhJ3ZjC0xgGi1YGTN4Q6IjfwWqOP9oo44mFt7A8QxoautbyjIs+
8z0yFHFroRs2jYwHGKT1fygXnRIlqjQ/k9xyeCU588/TLKXON/fZFt2B659i0Jg4
bkZGhdngcA7xp5rcXzgf7MfdvawEGJF5psr31yfb6KyB0qUffc8R6tEy/l0VJdSW
HPA2cp8+f2/9V9MIMHLANsy7BP4giRS8K7Iwh5cFLIVPpVcGk6HOjcoF4qIRk4NF
xYQmK9MS1U84txNiagtw9viFMKdQVd4xxJa3zMZPsQLBOh8rD06y7MLbAz2StI+7
cFvDgoClE8QeFphHAAL6I38JSFKp2PIbqJNZReetSiN9yg9DZusxR0uwHyCcuIA3
AVQricmFanjiTPKekGMU56Va6Bnfo13APfYCrhgZhobpi+JBq560TCZJ/kFCB79L
6hKEuUw42eKIzjYdvRgr16ElQMZ2WFQsHPH3vVPDp/gxV8nycR6eMhokGm9VgguA
0ma/I1zagFBmThPhlA5EGGKMVsFKUpKIeqMBk0eY4D3ZbiJtap+Ypd9uyGCoPBtg
OS57Q5OEWiEqUdw6WxSRb5btgwEuXF/+uJP3DXxJuw8cziP3coc=
=iDeP
-----END PGP SIGNATURE-----

--luhwbfkc5nm4f2sl--

