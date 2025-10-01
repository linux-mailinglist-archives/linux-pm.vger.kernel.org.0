Return-Path: <linux-pm+bounces-35607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90865BAED9A
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 02:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACC84A82BF
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 00:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4783C33;
	Wed,  1 Oct 2025 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROsUHBg0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A429A1;
	Wed,  1 Oct 2025 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759277053; cv=none; b=uAilne5cWE7MfMGBGVDT4fm8Hw8lWDE9H1cQhjUUXSwLhyBJpWbJ/xIXaAnECbt1K+DtPVBwvz/0gy3miMfivcRSPG0IxnXobDemzGFSsCrK6zn/BsMATVwSkCiGPo8rQvCBDVVCa0uG/YHhoYzwF9mnk7+/CuwHSucneE/c4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759277053; c=relaxed/simple;
	bh=6RstGi6qtLLB+zlmpNOCdc79aMmLjFORnqa57CQlV7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jcZ9VHqJSLltFTIN57CkPrn4xXf6OuN+lJwHgSZcaLOaCsSzDKqoob67ZV4PCuWGBkzIp8pOQ936JSUWm9hYFRqxGLuJXfodLWYA99hsNuOGO8AEAzaovdbFiAafqOwAhRBTOZOIRkAp8qOuiuhLZoXNpfN1Jn0cYgIiJdH6kbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROsUHBg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AACC4CEF0;
	Wed,  1 Oct 2025 00:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759277053;
	bh=6RstGi6qtLLB+zlmpNOCdc79aMmLjFORnqa57CQlV7c=;
	h=Date:From:To:Cc:Subject:From;
	b=ROsUHBg0x6WFi/QNqnyjAb3gE8pq+DBnSUU2O//DmSlEwejYYg/+hG6qdBku8laiW
	 8VlgywwWgc5kl2x8HnMu+87+5+kqyWnJH1qPzFc2V7ahdAbKcDAD9X29P58ZQJuy9K
	 8NwNBEBZXE5Gu+jiO1dp00sMDDq9AnB1L2F6UIzuA3avcO+et8gE9+hdITB845nkVP
	 CcxZq1Gj7/JjVwy+EnF8aySPiqoO9NahxAL8SlCIWOv4/oz0mifi7XlipAyXmY6L2Z
	 jIAcjCRVSfCGRlDJLDJcfK03utMqtihcqVi4fVptb+q2DnFvO9xngSGg/n6VFU0HX0
	 oShBXKRDAo1ag==
Received: by venus (Postfix, from userid 1000)
	id B43F2180734; Wed, 01 Oct 2025 02:04:08 +0200 (CEST)
Date: Wed, 1 Oct 2025 02:04:08 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.18
Message-ID: <vflh2stqeaa6rnwipi77v2k6cb3jynzja7qf2iznttqz26zbfg@7snfbz5gjdlz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kjeqn6ue7kfqaix6"
Content-Disposition: inline


--kjeqn6ue7kfqaix6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] power-supply changes for 6.18
MIME-Version: 1.0

Hi Linus,

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.18

for you to fetch changes up to 41307ec7df057239aae3d0f089cc35a0d735cdf8:

  power: supply: qcom_battmgr: handle charging state change notifications (=
2025-09-19 12:35:57 +0200)

----------------------------------------------------------------
power supply and reset changes for the 6.18 series

 * power-supply core
  - introduce adc-battery-helper for capacity estimation based on
    simple ADC readings of battery voltage and current
  - add new property for battery internal resistance
  - add new property for battery state of health
 * power-supply drivers
  - ug3105_battery: convert to adc-battery-helper
  - intel_dc_ti_battery: New driver for Intel Dollar Cove TI batteries
  - rt9467-charger: add voltage and current ADC support
  - sbs-charger: support multiple instances
  - qcom_battmgr: add charge control support
  - qcom_battmgr: add support for state of health and internal resistance
  - max77705_charger: big driver cleanup
  - max77705_charger: add support for setting charge current
  - misc. minor fixes and cleanups

----------------------------------------------------------------
Andy Yan (1):
      power: supply: cw2015: Fix a alignment coding style issue

ChiYuan Huang (1):
      power: supply: rt9467: Add properties for VBUS and IBUS reading

Christophe JAILLET (1):
      power: supply: Use devm_mutex_init()

Christopher Ruehl (1):
      power: supply: qcom_battmgr: add OOI chemistry

Colin Ian King (1):
      power: supply: 88pm860x: make fsm_state array static const, simplify =
usage

Darshan R. (1):
      power: supply: gpio-charger: Clean up spacing for better readability

Dzmitry Sankouski (8):
      power: supply: max77976_charger: fix constant current reporting
      mfd: max77705: max77705_charger: move active discharge setting to mfd=
 parent
      power: supply: max77705_charger: refactoring: rename charger to chg
      power: supply: max77705_charger: use regfields for config registers
      power: supply: max77705_charger: return error when config fails
      power: supply: max77705_charger: add writable properties
      power: supply: max77705_charger: rework interrupts
      power: supply: max77705_charger: use REGMAP_IRQ_REG_LINE macro

Fabien Proriol (1):
      power: supply: sbs-charger: Support multiple devices

Fenglin Wu (8):
      power: supply: core: Add resistance power supply property
      power: supply: core: Add state_of_health power supply property
      power: supply: qcom_battmgr: Add resistance power supply property
      power: supply: qcom_battmgr: Add state_of_health property
      power: supply: qcom_battmgr: update compats for SM8550 and X1E80100
      dt-bindings: soc: qcom,pmic-glink: Add charge limit nvmem properties
      power: supply: qcom_battmgr: Add charge control support
      power: supply: qcom_battmgr: handle charging state change notificatio=
ns

Hans de Goede (6):
      power: supply: Add adc-battery-helper
      power: supply: ug3105_battery: Switch to adc-battery-helper
      power: supply: ug3105_battery: Put FG in standby on remove and shutdo=
wn
      power: supply: adc-battery-helper: Add support for optional charge_fi=
nished GPIO
      power: supply: Add new Intel Dollar Cove TI battery driver
      power: supply: intel_dc_ti_battery: Drop no longer relevant comment

Marco Crivellari (2):
      power: supply: replace use of system_wq with system_percpu_wq
      power: supply: WQ_PERCPU added to alloc_workqueue users

Miguel Garc=EDa (1):
      power: supply: bq2415x: replace deprecated strcpy() with strscpy()

Qianfeng Rong (1):
      power: supply: use max() to improve code

Sebastian Reichel (1):
      Merge tag 'ib-max77705-for-v6.17-signed'

Svyatoslav Ryhel (2):
      dt-bindings: power: supply: bq27xxx: document optional interrupt
      dt-bindings: power: supply: bq24190: document charge enable pin

Waqar Hameed (1):
      power: supply: Remove error prints for devm_add_action_or_reset()

Xichao Zhao (2):
      power: supply: Remove the use of dev_err_probe()
      power: supply: rx51: remove redundant condition checks

 Documentation/ABI/testing/sysfs-class-power        |  37 ++
 .../devicetree/bindings/power/supply/bq24190.yaml  |   6 +
 .../devicetree/bindings/power/supply/bq27xxx.yaml  |  37 +-
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |  14 +
 drivers/mfd/max77705.c                             |   3 +
 drivers/power/supply/88pm860x_charger.c            |   8 +-
 drivers/power/supply/Kconfig                       |  16 +
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/ab8500_btemp.c                |   3 +-
 drivers/power/supply/adc-battery-helper.c          | 327 +++++++++++++++++
 drivers/power/supply/adc-battery-helper.h          |  62 ++++
 drivers/power/supply/bq2415x_charger.c             |   4 +-
 drivers/power/supply/bq24190_charger.c             |   2 +-
 drivers/power/supply/bq27xxx_battery.c             |  17 +-
 drivers/power/supply/cw2015_battery.c              |   8 +-
 drivers/power/supply/gpio-charger.c                |   7 +-
 drivers/power/supply/intel_dc_ti_battery.c         | 389 +++++++++++++++++=
++++
 drivers/power/supply/ipaq_micro_battery.c          |   3 +-
 drivers/power/supply/max77705_charger.c            | 330 ++++++++++-------
 drivers/power/supply/max77976_charger.c            |  12 +-
 drivers/power/supply/mt6370-charger.c              |  18 +-
 drivers/power/supply/power_supply_sysfs.c          |   2 +
 drivers/power/supply/qcom_battmgr.c                | 324 ++++++++++++++++-
 drivers/power/supply/rk817_charger.c               |   6 +-
 drivers/power/supply/rt9467-charger.c              |  47 +--
 drivers/power/supply/rx51_battery.c                |   2 +-
 drivers/power/supply/sbs-charger.c                 |  16 +-
 drivers/power/supply/sbs-manager.c                 |   2 +-
 drivers/power/supply/ucs1002_power.c               |   2 +-
 drivers/power/supply/ug3105_battery.c              | 346 ++++--------------
 include/linux/power/max77705_charger.h             | 144 ++++----
 include/linux/power_supply.h                       |   2 +
 32 files changed, 1609 insertions(+), 589 deletions(-)
 create mode 100644 drivers/power/supply/adc-battery-helper.c
 create mode 100644 drivers/power/supply/adc-battery-helper.h
 create mode 100644 drivers/power/supply/intel_dc_ti_battery.c

--kjeqn6ue7kfqaix6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjcb/gACgkQ2O7X88g7
+prZYg/8Cqb4tclZj+XL/VGtGrGbgo1a93hRTHqBqarGB66bkJYPXzCxKg4kSMAg
NSGM+MTMZOlaQ9AENNgfIPNuTOPFiC0U6up2yGpqNK+6w6kF4f8PBCnhbLhUnjdo
Cjn8qNXCZoM1ZqFq+FuLuEmprW9u12co67wYNDM/min3+pypz7zqwKMTQX+AI37R
nD+/A4Y8O6fk4p/e24fPB51ggUZFv4LdRLQ6GyY5imVoI1a9hU6JmW157i8ZCJGe
k2VNykyDf0zhXQHrvLO7zfPBSJJJsvI7S3+s/OpthxnQfOeuLlNv478P/RV/9K47
5pT1jHNPdagCXqT1zfpGEnzSuXGYAf5gHn+qT7NXgDtJiB+Jl4DyLCaBSkkCpXI0
aTEsEiTGwaa1zzQwQpPO2YG287FsbGuZTZe5sWmp/tn1WvGN7IK3uLLEq8/OPnq+
+EvB4gvEr/UakYMhsCBiyVWFzcPPID21ELZMutTfKTfyz/poI9nzouIqYOnNe8bv
AxdKpJowpm7Aw293QE9ensG5soTF/m8qU7fVLUva99xt9kg01GYFqhHkrhOEX/I0
fR62kh1yz7SUT9n1w1S+AGu75Y1MMiElazKnHM3ghY4ehi1vja60FtPAxkr5uqLK
o5VQ1+TkK0AQ/Mo6xNf0bIoyOkcWX1Faca+Za/JL5wjiR/O2SSY=
=pFJs
-----END PGP SIGNATURE-----

--kjeqn6ue7kfqaix6--

