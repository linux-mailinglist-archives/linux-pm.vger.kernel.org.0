Return-Path: <linux-pm+bounces-14211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC41978AFD
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 23:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F8FB2174A
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 21:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B89155A5D;
	Fri, 13 Sep 2024 21:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyRJIjcO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC5126BE6;
	Fri, 13 Sep 2024 21:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726264682; cv=none; b=DC5u0iuzjLzDGVdMNddzx9O/gHdIciRu0W6Ct2PL+VKtHdc3xoI087J0kQSY6eruM9+41ujtO98rbrx2GFuenF8j0W3JA7HJMrsC75KB/IsmW7iPaFvlHGnb5RHo81yWqnEMLOwbiA5EHzaG5DmI2f2SHjT7iBvRLe/sJuxhRzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726264682; c=relaxed/simple;
	bh=JEz+V7c1IsclmVC8nmtJlJglD79bVj3sixux0gkyPSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb2B+dcEmFhM1PNLBgAvDOqEjk/NvWmbr+szLuAEcWdRGZN0SH5M7tYeI77w3OEyPQXAM/QjZ1LpFBluiSGWEjtDNmnbuDvfPWlI2oxdZ3EN1szWAX1KI6jhX+bHFfRYR53F/Bn0y2oIy+A1Ue/+qfhZ55B6Y3uTk+SYUBnLC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyRJIjcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E18C4CEC0;
	Fri, 13 Sep 2024 21:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726264682;
	bh=JEz+V7c1IsclmVC8nmtJlJglD79bVj3sixux0gkyPSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pyRJIjcORp6cMeAjtmeVzgth9pOAMPpumvGJjY/gHMGFF+l6PnD5oOue1E4mVszwa
	 0kZ5unWfIoGj/n/IGiXkZEY2CRkYCrNcZQ2ACDmchFttOBJPGQ4OUzGAQYbQ/cWMlR
	 ZYJGoGjTinrCYxuA0Us6C82es8xI3mp0Kqn/aX66cH/pbD7QjvlgocucJ2d0Exdk8d
	 C7wtuAd5/F7+Qf46tZ4TLmMznApgbeI0KsMne6c/VzQ21Jlo4zbjxpE6YJtDDaoUA8
	 9q6AuqNeyG04FLIc9nio9D2ZaFQgh8csQQHQd7OiieM/zYpERM65QR9ZJTdSbcEM1L
	 6E5nrB+q6jiXw==
Date: Fri, 13 Sep 2024 16:58:01 -0500
From: Rob Herring <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-leds@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>, Lee Jones <lee@kernel.org>,
	linux-mediatek@lists.infradead.org, Macpaul Lin <macpaul@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-rtc@vger.kernel.org,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Pablo Sun <pablo.sun@mediatek.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Message-ID: <20240913215801.GA870426-robh@kernel.org>
References: <20240913175926.7443-1-macpaul.lin@mediatek.com>
 <172625540069.478205.2893721075637493498.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <172625540069.478205.2893721075637493498.robh@kernel.org>

On Fri, Sep 13, 2024 at 02:23:20PM -0500, Rob Herring (Arm) wrote:
>=20
> On Sat, 14 Sep 2024 01:59:26 +0800, Macpaul Lin wrote:
> > Convert the mfd: mediatek: mt6397 binding to DT schema format.
> >=20
> > MT6323, MT6358, and MT6397 are PMIC devices with multiple function
> > subdevices. They share a common PMIC design but have variations in
> > subdevice combinations.
> >=20
> > Key updates in this conversion:
> >=20
> > 1. RTC:
> >    - Convert rtc-mt6397.txt and merge into parent MT6397 PMIC DT schema.
> >=20
> > 2. Regulators:
> >    - Align to generic name "regulators".
> >    - Update references from .txt to .yaml for mt6323, mt6358, and mt6397
> >      regulators.
> >    - Simplify regulator name labels in device tree examples.
> >=20
> > 3. Audio Codec:
> >    - Convert sound/mt6358.txt and merge into parent MT6397 PMIC DT sche=
ma.
> >    - Align to generic name "audio-codec" for codec and sound subdevices.
> >    - Add "mediatek,dmic-mode" and "Avdd-supply" properties.
> >=20
> > 4. Clocks:
> >    - Align to generic name "clocks" for clockbuffer subdevices.
> >=20
> > 5. LEDs:
> >    - Convert leds-mt6323.txt and merge into parent MT6397 PMIC DT schem=
a.
> >    - Update LED binding.
> >=20
> > 6. Keys:
> >    - Add detailed descriptions for power and home keys.
> >    - Add compatible: mediatek,mt6358-keys.
> >=20
> > 7. Power Controller:
> >    - Convert mt6323-poweroff.txt and merge into parent MT6397 PMIC DT
> >      schema.
> >    - Add #power-domain-cells property to fix dt-binding check error.
> >    - Clarify "BBPU" as "Baseband power up".
> >=20
> > 8. Pinctrl:
> >    - Align to generic name "pinctrl" instead of "pin-controller".
> >=20
> > Additional updates:
> > - MAINTAINERS: Add co-maintainers and reference to
> >   mfd/mediatek,mt6397.yaml for LED and power-controller drivers.
> > - input/mediatek,pmic-keys.yaml: Update reference to
> >   mfd/mediatek,mt6397.yaml.
> >=20
> > Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> > Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> > ---
> >  .../bindings/input/mediatek,pmic-keys.yaml    |    2 +-
> >  .../devicetree/bindings/leds/leds-mt6323.txt  |   63 -
> >  .../bindings/mfd/mediatek,mt6397.yaml         | 1078 +++++++++++++++++
> >  .../devicetree/bindings/mfd/mt6397.txt        |  110 --
> >  .../bindings/power/reset/mt6323-poweroff.txt  |   20 -
> >  .../devicetree/bindings/rtc/rtc-mt6397.txt    |   31 -
> >  .../devicetree/bindings/sound/mt6358.txt      |   26 -
> >  MAINTAINERS                                   |    8 +-
> >  8 files changed, 1085 insertions(+), 253 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.=
txt
> >  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt63=
97.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt
> >  delete mode 100644 Documentation/devicetree/bindings/power/reset/mt632=
3-poweroff.txt
> >  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> >  delete mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt
> >=20
> > Changes for v1:
> >  - This patch depends on conversion of mediatek,mt6397-regulator.yaml
> >    [1] https://lore.kernel.org/lkml/20240807091738.18387-1-macpaul.lin@=
mediatek.com/T/
> >=20
> > Changes for v2:
> >  - This patch has been made base on linux-next/master git repo.
> >  - Keep the parent and child relationship with mediatek,pwrap in descri=
ption.
> >    [2] https://lore.kernel.org/all/20240826-slurp-earphone-0d5173923ae8=
@spud/
> >  - Keep the $ref for regulators since dt_binding_check didn't report an=
y issue
> >    based on linux-next/master repo.
> >  - Fix description of mt6397/mt6323 devices, use "power management chip"
> >    instead of "multifunction device"
> >  - Drop unnecessary comments or description according to the review.
> >  - Convert sub-modules to DT Schema:
> >   - RTC, LEDs, power-controllers, regulators
> >  - Drop duplicate sub node name and description for sub-modules
> >   - RTC, Keys
> >  - examples:
> >   - drop parent pwrap node
> >   - Add examples from mediatek,mt6323-regulator.yaml
> >   - Add examples from mediatek,mt6358-regulator.yaml
> >   - Add examples from mediatek,mt6397-regulator.yaml
> >   - Complete the examples as could as possible.
> >=20
> > Changes for v3:
> >  - Rebased on linux-next/master git repo near next-20240906.
> >  - Revise commit message.
> >  - Regulators:
> >   - Use "additionalProperties: true" and add "contains" for matching
> >     $ref DT bindings.
> >   - Simplify regulator name labels in device tree examples.
> >  - LEDs:
> >   - Use LED bindings.
> >  - Squash following patches in v2 for removing old text format DT bindi=
ngs
> >    into this patch, includes:
> >   - leds-mt6323.txt, mt6323-poweroff.txt, rtc-mt6397.txt, sound/mt6358.=
txt.
> >  - Fix file format of DT schemas, add blank between properties.
> >  - Fix 'make checkrefdoc' errors, update reference in mediatek,pmic-key=
s.yaml.
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Warning: Duplicate compatible "mediatek,mt6357" found in schemas matching=
 "$id":
> 	http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
> 	http://devicetree.org/schemas/mfd/mediatek,mt6357.yaml#

There's a new warning in dtschema main branch.

> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
fd/mediatek,mt6397.example.dtb: pmic: regulators: False schema does not all=
ow {'compatible': ['mediatek,mt6323-regulator'], 'buck_vproc': {'regulator-=
name': ['vproc'], 'regulator-min-microvolt': [[700000]], 'regulator-max-mic=
rovolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-always-on':=
 True, 'regulator-boot-on': True}, 'buck_vsys': {'regulator-name': ['vsys']=
, 'regulator-min-microvolt': [[1400000]], 'regulator-max-microvolt': [[2987=
500]], 'regulator-ramp-delay': 25000, 'regulator-always-on': True, 'regulat=
or-boot-on': True}, 'buck_vpa': {'regulator-name': ['vpa'], 'regulator-min-=
microvolt': [[500000]], 'regulator-max-microvolt': [[3650000]]}, 'ldo_vtcxo=
': {'regulator-name': ['vtcxo'], 'regulator-min-microvolt': [[2800000]], 'r=
egulator-max-microvolt': [[2800000]], 'regulator-enable-ramp-delay': 90, 'r=
egulator-always-on': True, 'regulator-boot-on': True}, 'ldo_vcn28': {'regul=
ator-name': ['vcn28'], 'regulator-min-microvolt': [[2800000]], 'regulator-m=
ax-microvolt': [[2800000]], 'regulator-enable-ramp-delay': 185}, 'ldo_vcn33=
_bt': {'regulator-name': ['vcn33_bt'], 'regulator-min-microvolt': [[3300000=
]], 'regulator-max-microvolt': [[3600000]], 'regulator-enable-ramp-delay': =
185}, 'ldo_vcn33_wifi': {'regulator-name': ['vcn33_wifi'], 'regulator-min-m=
icrovolt': [[3300000]], 'regulator-max-microvolt': [[3600000]], 'regulator-=
enable-ramp-delay': 185}, 'ldo_va': {'regulator-name': ['va'], 'regulator-m=
in-microvolt': [[2800000]], 'regulator-max-microvolt': [[2800000]], 'regula=
tor-enable-ramp-delay': 216, 'regulator-always-on': True, 'regulator-boot-o=
n': True}, 'ldo_vcama': {'regulator-name': ['vcama'], 'regulator-min-microv=
olt': [[1500000]], 'regulator-max-microvolt': [[2800000]], 'regulator-enabl=
e-ramp-delay': 216}, 'ldo_vio28': {'regulator-name': ['vio28'], 'regulator-=
min-microvolt': [[2800000]], 'regulator-max-microvolt': [[2800000]], 'regul=
ator-enable-ramp-delay': 216, 'regulator-always-on': True, 'regulator-boot-=
on': True}, 'ldo_vusb': {'regulator-name': ['vusb'], 'regulator-min-microvo=
lt': [[3300000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable=
-ramp-delay': 216, 'regulator-boot-on': True}, 'ldo_vmc': {'regulator-name'=
: ['vmc'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt=
': [[3300000]], 'regulator-enable-ramp-delay': 36, 'regulator-boot-on': Tru=
e}, 'ldo_vmch': {'regulator-name': ['vmch'], 'regulator-min-microvolt': [[3=
000000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-de=
lay': 36, 'regulator-boot-on': True}, 'ldo_vemc3v3': {'regulator-name': ['v=
emc3v3'], 'regulator-min-microvolt': [[3000000]], 'regulator-max-microvolt'=
: [[3300000]], 'regulator-enable-ramp-delay': 36, 'regulator-boot-on': True=
}, 'ldo_vgp1': {'regulator-name': ['vgp1'], 'regulator-min-microvolt': [[12=
00000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-del=
ay': 216}, 'ldo_vgp2': {'regulator-name': ['vgp2'], 'regulator-min-microvol=
t': [[1200000]], 'regulator-max-microvolt': [[3000000]], 'regulator-enable-=
ramp-delay': 216}, 'ldo_vgp3': {'regulator-name': ['vgp3'], 'regulator-min-=
microvolt': [[1200000]], 'regulator-max-microvolt': [[1800000]], 'regulator=
-enable-ramp-delay': 216}, 'ldo_vcn18': {'regulator-name': ['vcn18'], 'regu=
lator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[1800000]], =
'regulator-enable-ramp-delay': 216}, 'ldo_vsim1': {'regulator-name': ['vsim=
1'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[3=
000000]], 'regulator-enable-ramp-delay': 216}, 'ldo_vsim2': {'regulator-nam=
e': ['vsim2'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-micro=
volt': [[3000000]], 'regulator-enable-ramp-delay': 216}, 'ldo_vrtc': {'regu=
lator-name': ['vrtc'], 'regulator-min-microvolt': [[2800000]], 'regulator-m=
ax-microvolt': [[2800000]], 'regulator-always-on': True, 'regulator-boot-on=
': True}, 'ldo_vcamaf': {'regulator-name': ['vcamaf'], 'regulator-min-micro=
volt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enab=
le-ramp-delay': 216}, 'ldo_vibr': {'regulator-name': ['vibr'], 'regulator-m=
in-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regula=
tor-enable-ramp-delay': 36}, 'ldo_vrf18': {'regulator-name': ['vrf18'], 're=
gulator-min-microvolt': [[1825000]], 'regulator-max-microvolt': [[1825000]]=
, 'regulator-enable-ramp-delay': 187}, 'ldo_vm': {'regulator-name': ['vm'],=
 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[18000=
00]], 'regulator-enable-ramp-delay': 216, 'regulator-always-on': True, 'reg=
ulator-boot-on': True}, 'ldo_vio18': {'regulator-name': ['vio18'], 'regulat=
or-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[1800000]], 're=
gulator-enable-ramp-delay': 216, 'regulator-always-on': True, 'regulator-bo=
ot-on': True}, 'ldo_vcamd': {'regulator-name': ['vcamd'], 'regulator-min-mi=
crovolt': [[1200000]], 'regulator-max-microvolt': [[1800000]], 'regulator-e=
nable-ramp-delay': 216}, 'ldo_vcamio': {'regulator-name': ['vcamio'], 'regu=
lator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[1800000]], =
'regulator-enable-ramp-delay': 216}}
> 	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
fd/mediatek,mt6397.example.dtb: pmic: regulators: False schema does not all=
ow {'compatible': ['mediatek,mt6397-regulator'], 'buck_vpca15': {'regulator=
-name': ['vpca15'], 'regulator-min-microvolt': [[850000]], 'regulator-max-m=
icrovolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ra=
mp-delay': 200}, 'buck_vpca7': {'regulator-name': ['vpca7'], 'regulator-min=
-microvolt': [[850000]], 'regulator-max-microvolt': [[1350000]], 'regulator=
-ramp-delay': 12500, 'regulator-enable-ramp-delay': 115}, 'buck_vsramca15':=
 {'regulator-name': ['vsramca15'], 'regulator-min-microvolt': [[850000]], '=
regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay': 12500, 'regu=
lator-enable-ramp-delay': 115}, 'buck_vsramca7': {'regulator-name': ['vsram=
ca7'], 'regulator-min-microvolt': [[850000]], 'regulator-max-microvolt': [[=
1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay': 11=
5}, 'buck_vcore': {'regulator-name': ['vcore'], 'regulator-min-microvolt': =
[[850000]], 'regulator-max-microvolt': [[1350000]], 'regulator-ramp-delay':=
 12500, 'regulator-enable-ramp-delay': 115}, 'buck_vgpu': {'regulator-name'=
: ['vgpu'], 'regulator-min-microvolt': [[700000]], 'regulator-max-microvolt=
': [[1350000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp-delay=
': 115}, 'buck_vdrm': {'regulator-name': ['vdrm'], 'regulator-min-microvolt=
': [[800000]], 'regulator-max-microvolt': [[1400000]], 'regulator-ramp-dela=
y': 12500, 'regulator-enable-ramp-delay': 500}, 'buck_vio18': {'regulator-n=
ame': ['vio18'], 'regulator-min-microvolt': [[1500000]], 'regulator-max-mic=
rovolt': [[2120000]], 'regulator-ramp-delay': 12500, 'regulator-enable-ramp=
-delay': 500}, 'ldo_vtcxo': {'regulator-name': ['vtcxo'], 'regulator-min-mi=
crovolt': [[2800000]], 'regulator-max-microvolt': [[2800000]], 'regulator-e=
nable-ramp-delay': 90}, 'ldo_va28': {'regulator-name': ['va28'], 'regulator=
-enable-ramp-delay': 218}, 'ldo_vcama': {'regulator-name': ['vcama'], 'regu=
lator-min-microvolt': [[1500000]], 'regulator-max-microvolt': [[2800000]], =
'regulator-enable-ramp-delay': 218}, 'ldo_vio28': {'regulator-name': ['vio2=
8'], 'regulator-enable-ramp-delay': 240}, 'ldo_vusb': {'regulator-name': ['=
vusb'], 'regulator-enable-ramp-delay': 218}, 'ldo_vmc': {'regulator-name': =
['vmc'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt':=
 [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vmch': {'regulator-=
name': ['vmch'], 'regulator-min-microvolt': [[3000000]], 'regulator-max-mic=
rovolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vemc3v3': {=
'regulator-name': ['vemc_3v3'], 'regulator-min-microvolt': [[3000000]], 're=
gulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}, '=
ldo_vgp1': {'regulator-name': ['vcamd'], 'regulator-min-microvolt': [[12200=
00]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay'=
: 240}, 'ldo_vgp2': {'regulator-name': ['vcamio'], 'regulator-min-microvolt=
': [[1000000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-r=
amp-delay': 218}, 'ldo_vgp3': {'regulator-name': ['vcamaf'], 'regulator-min=
-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regulato=
r-enable-ramp-delay': 218}, 'ldo_vgp4': {'regulator-name': ['vgp4'], 'regul=
ator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], '=
regulator-enable-ramp-delay': 218}, 'ldo_vgp5': {'regulator-name': ['vgp5']=
, 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3000=
000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vgp6': {'regulator-name': =
['vgp6'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt'=
: [[3300000]], 'regulator-enable-ramp-delay': 218}, 'ldo_vibr': {'regulator=
-name': ['vibr'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-mi=
crovolt': [[3300000]], 'regulator-enable-ramp-delay': 218}}
> 	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#

This probably fails because the threading of your series seems to be=20
messed up.

Rob

