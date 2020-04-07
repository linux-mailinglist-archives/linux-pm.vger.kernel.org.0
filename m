Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A66C01A0CCD
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 13:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgDGL0x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 07:26:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33085 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgDGL0w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 07:26:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id g21so365722wmh.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2020 04:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=olCGLP7xbQsAoEeEye7wKoPLT9nGn1j8oYNSFGfneco=;
        b=bFdXE9V6b00Q7Erg+1mA9Jc0NLj9v+4F+20FXF5668CbQMN/Jbajfsx+yNWg49GF4L
         MgjL6ThLTHBjm6QQsV8LDyOGIN69+UbPweuClHy90bDEiG9JuWEpit4oJKbOk7TcMAmL
         xKaTw2V+AYVl9WeN1mOcVtbgKSjUlY06GQlVAQ8RharN5OX3uh8C3PZ5Ol2uvocWlP70
         IVdQRyTWQQNC/mnRT2xL73DTR3MPPz8IwwpdWeb7P8Ne20DJLlbCgSuxJRbD06Y+tqfB
         6nEgT3+TNYODm0qfm44HlUY0Bmsn2eHDj5tXFL4e+VINYA33oVIzgwy97SLy9/Me6+ZC
         tEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=olCGLP7xbQsAoEeEye7wKoPLT9nGn1j8oYNSFGfneco=;
        b=jZ8p//j8K8iC0NZPN+uX9Txm3Y7a45ZW1jX9LZjNRncURM6gidYtiWhW6Doe+QVyoD
         svUSAo6/Sfy/ZJ0+n4F+kOabZoZqTyT158SbKKjZV+nTRHFyWY5FVFntLvAvZZg6hWlM
         Q4w9bqcOzDxa4RfoCl12Bvn1waVCaZkDbUlyXbOU2KMdM+BIR2Ak7t2I4JAxKZMt5kh0
         sE4nYLd8LR8rJj2mh/VSiwQl0ELT7bydCUVYivMAmabmRtTElVEQeIvgSErKZ646Mgnn
         fYy60Avp1KJtfZhyB369u5EnLwHeBBoe5sZtR6RI7bKvYJWOvjgcmh4ub1rP/qXzym+1
         4Qww==
X-Gm-Message-State: AGi0PuZGQtirnbaq4bpNygTput1oxrZ9fwBM7lHZFg0zIUw0ErbLQkEF
        uR7gCjB5czDg6o/uE4Wh0h/Dpw==
X-Google-Smtp-Source: APiQypJvHMdN+SjqNWtJfl4z9pmSFvq5gGPqdigP6D91Mdk8bELdI8W5brcSABIOZfn6QX1nABr7Zg==
X-Received: by 2002:a1c:5ac4:: with SMTP id o187mr1990409wmb.79.1586258810082;
        Tue, 07 Apr 2020 04:26:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b51c:42dc:1499:2880? ([2a01:e34:ed2f:f020:b51c:42dc:1499:2880])
        by smtp.googlemail.com with ESMTPSA id y7sm29514362wrq.54.2020.04.07.04.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 04:26:49 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v5.7-rc1
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 xsFNBFv/yykBEADDdW8RZu7iZILSf3zxq5y8YdaeyZjI/MaqgnvG/c3WjFaunoTMspeusiFE
 sXvtg3ehTOoyD0oFjKkHaia1Zpa1m/gnNdT/WvTveLfGA1gH+yGes2Sr53Ht8hWYZFYMZc8V
 2pbSKh8wepq4g8r5YI1XUy9YbcTdj5mVrTklyGWA49NOeJz2QbfytMT3DJmk40LqwK6CCSU0
 9Ed8n0a+vevmQoRZJEd3Y1qXn2XHys0F6OHCC+VLENqNNZXdZE9E+b3FFW0lk49oLTzLRNIq
 0wHeR1H54RffhLQAor2+4kSSu8mW5qB0n5Eb/zXJZZ/bRiXmT8kNg85UdYhvf03ZAsp3qxcr
 xMfMsC7m3+ADOtW90rNNLZnRvjhsYNrGIKH8Ub0UKXFXibHbafSuq7RqyRQzt01Ud8CAtq+w
 P9EftUysLtovGpLSpGDO5zQ++4ZGVygdYFr318aGDqCljKAKZ9hYgRimPBToDedho1S1uE6F
 6YiBFnI3ry9+/KUnEP6L8Sfezwy7fp2JUNkUr41QF76nz43tl7oersrLxHzj2dYfWUAZWXva
 wW4IKF5sOPFMMgxoOJovSWqwh1b7hqI+nDlD3mmVMd20VyE9W7AgTIsvDxWUnMPvww5iExlY
 eIC0Wj9K4UqSYBOHcUPrVOKTcsBVPQA6SAMJlt82/v5l4J0pSQARAQABzSpEYW5pZWwgTGV6
 Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz7Cwa4EEwEIAEECGwEFCwkIBwIGFQoJ
 CAsCBBYCAwECHgECF4ACGQEWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXAkeagUJDRnjhwAh
 CRCP9LjScWdVJxYhBCTWJvJTvp6H5s5b9I/0uNJxZ1Un69gQAJK0ODuKzYl0TvHPU8W7uOeu
 U7OghN/DTkG6uAkyqW+iIVi320R5QyXN1Tb6vRx6+yZ6mpJRW5S9fO03wcD8Sna9xyZacJfO
 UTnpfUArs9FF1pB3VIr95WwlVoptBOuKLTCNuzoBTW6jQt0sg0uPDAi2dDzf+21t/UuF7I3z
 KSeVyHuOfofonYD85FkQJN8lsbh5xWvsASbgD8bmfI87gEbt0wq2ND5yuX+lJK7FX4lMO6gR
 ZQ75g4KWDprOO/w6ebRxDjrH0lG1qHBiZd0hcPo2wkeYwb1sqZUjQjujlDhcvnZfpDGR4yLz
 5WG+pdciQhl6LNl7lctNhS8Uct17HNdfN7QvAumYw5sUuJ+POIlCws/aVbA5+DpmIfzPx5Ak
 UHxthNIyqZ9O6UHrVg7SaF3rvqrXtjtnu7eZ3cIsfuuHrXBTWDsVwub2nm1ddZZoC530BraS
 d7Y7eyKs7T4mGwpsi3Pd33Je5aC/rDeF44gXRv3UnKtjq2PPjaG/KPG0fLBGvhx0ARBrZLsd
 5CTDjwFA4bo+pD13cVhTfim3dYUnX1UDmqoCISOpzg3S4+QLv1bfbIsZ3KDQQR7y/RSGzcLE
 z164aDfuSvl+6Myb5qQy1HUQ0hOj5Qh+CzF3CMEPmU1v9Qah1ThC8+KkH/HHjPPulLn7aMaK
 Z8t6h7uaAYnGzjMEXZLIEhYJKwYBBAHaRw8BAQdAGdRDglTydmxI03SYiVg95SoLOKT5zZW1
 7Kpt/5zcvt3CwhsEGAEIACAWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXZLIEgIbAgCvCRCP
 9LjScWdVJ40gBBkWCAAdFiEEbinX+DPdhovb6oob3uarTi9/eqYFAl2SyBIAIQkQ3uarTi9/
 eqYWIQRuKdf4M92Gi9vqihve5qtOL396pnZGAP0c3VRaj3RBEOUGKxHzcu17ZUnIoJLjpHdk
 NfBnWU9+UgD/bwTxE56Wd8kQZ2e2UTy4BM8907FsJgAQLL4tD2YZggwWIQQk1ibyU76eh+bO
 W/SP9LjScWdVJ5CaD/0YQyfUzjpR1GnCSkbaLYTEUsyaHuWPI/uSpKTtcbttpYv+QmYsIwD9
 8CeH3zwY0Xl/1fE9Hy59z6Vxv9YVapLx0nPDOA1zDVNq2MnutxHb8t+Imjz4ERCxysqtfYrv
 gao3E/h0c8SEeh+bh5MkjwmU8CwZ3doWyiVdULKESe7/Gs5OuhFzaDVPCpWdsKdCAGyUuP/+
 qRWwKGVpWP0Rrt6MTK24Ibeu3xEZO8c3XOEXH5d9nf6YRqBEIizAecoCr00E9c+6BlRS0AqR
 OQC3/Mm7rWtco3+WOridqVXkko9AcZ8AiM5nu0F8AqYGKg0y7vkL2LOP8us85L0p57MqIR1u
 gDnITlTY0x4RYRWJ9+k7led5WsnWlyv84KNzbDqQExTm8itzeZYW9RvbTS63r/+FlcTa9Cz1
 5fW3Qm0BsyECvpAD3IPLvX9jDIR0IkF/BQI4T98LQAkYX1M/UWkMpMYsL8tLObiNOWUl4ahb
 PYi5Yd8zVNYuidXHcwPAUXqGt3Cs+FIhihH30/Oe4jL0/2ZoEnWGOexIFVFpue0jdqJNiIvA
 F5Wpx+UiT5G8CWYYge5DtHI3m5qAP9UgPuck3N8xCihbsXKX4l8bdHfziaJuowief7igeQs/
 WyY9FnZb0tl29dSa7PdDKFWu+B+ZnuIzsO5vWMoN6hMThTl1DxS+jc7ATQRb/8z6AQgAvSkg
 5w7dVCSbpP6nXc+i8OBz59aq8kuL3YpxT9RXE/y45IFUVuSc2kuUj683rEEgyD7XCf4QKzOw
 +XgnJcKFQiACpYAowhF/XNkMPQFspPNM1ChnIL5KWJdTp0DhW+WBeCnyCQ2pzeCzQlS/qfs3
 dMLzzm9qCDrrDh/aEegMMZFO+reIgPZnInAcbHj3xUhz8p2dkExRMTnLry8XXkiMu9WpchHy
 XXWYxXbMnHkSRuT00lUfZAkYpMP7La2UudC/Uw9WqGuAQzTqhvE1kSQe0e11Uc+PqceLRHA2
 bq/wz0cGriUrcCrnkzRmzYLoGXQHqRuZazMZn2/pSIMZdDxLbwARAQABwsGNBBgBCAAgFiEE
 JNYm8lO+nofmzlv0j/S40nFnVScFAlv/zPoCGwwAIQkQj/S40nFnVScWIQQk1ibyU76eh+bO
 W/SP9LjScWdVJ/g6EACFYk+OBS7pV9KZXncBQYjKqk7Kc+9JoygYnOE2wN41QN9Xl0Rk3wri
 qO7PYJM28YjK3gMT8glu1qy+Ll1bjBYWXzlsXrF4szSqkJpm1cCxTmDOne5Pu6376dM9hb4K
 l9giUinI4jNUCbDutlt+Cwh3YuPuDXBAKO8YfDX2arzn/CISJlk0d4lDca4Cv+4yiJpEGd/r
 BVx2lRMUxeWQTz+1gc9ZtbRgpwoXAne4iw3FlR7pyg3NicvR30YrZ+QOiop8psWM2Fb1PKB9
 4vZCGT3j2MwZC50VLfOXC833DBVoLSIoL8PfTcOJOcHRYU9PwKW0wBlJtDVYRZ/CrGFjbp2L
 eT2mP5fcF86YMv0YGWdFNKDCOqOrOkZVmxai65N9d31k8/O9h1QGuVMqCiOTULy/h+FKpv5q
 t35tlzA2nxPOX8Qj3KDDqVgQBMYJRghZyj5+N6EKAbUVa9Zq8xT6Ms2zz/y7CPW74G1GlYWP
 i6D9VoMMi6ICko/CXUZ77OgLtMsy3JtzTRbn/wRySOY2AsMgg0Sw6yJ0wfrVk6XAMoLGjaVt
 X4iPTvwocEhjvrO4eXCicRBocsIB2qZaIj3mlhk2u4AkSpkKm9cN0KWYFUxlENF4/NKWMK+g
 fGfsCsS3cXXiZpufZFGr+GoHwiELqfLEAQ9AhlrHGCKcgVgTOI6NHg==
Message-ID: <49c5b834-362d-0569-32c5-76d366cb0a44@linaro.org>
Date:   Tue, 7 Apr 2020 13:26:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes since commit
f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.7-rc1

for you to fetch changes up to 11700fcb90b40a38fbfba55b2bedfc9909be8ec8:

  Documentation: cpu-idle-cooling: Fix diagram for 33% duty cycle
(2020-04-07 10:45:15 +0200)

----------------------------------------------------------------
- Convert tsens configuration DT binding to yaml (Rajeshwari)

- Add interrupt support on the rcar sensor (Niklas Söderlund)

- Add a new Spreadtrum thermal driver (Baolin Wang)

- Add thermal binding for the fsl scu board, a new API to retrieve the
  sensor id bound to the thermal zone and i.MX system controller
  sensor (Anson Huang))

- Remove warning log when a deferred probe is requested on Exynos
  (Marek Szyprowski)

- Add the thermal monitoring unit support for imx8mm with its DT
  bindings (Anson Huang)

- Rephrase the Kconfig text for clarity (Linus Walleij)

- Use the gpio descriptor for the ti-soc-thermal (Linus Walleij)

- Align msg structure to 4 bytes for i.MX SC, fix the Kconfig
  dependency, add the __may_be unused annotation for PM functions and
  the COMPILE_TEST option for imx8mm (Anson Huang)

- Fix a dependency on regmap in Kconfig for qoriq (Yuantian Tang)

- Add DT binding and support for the rcar gen3 r8a77961 and improve
  the error path on the rcar init function (Niklas Söderlund)

- Cleanup and improvements for the tsens Qcom sensor (Amit Kucheria)

- Improve code by removing lock and caching values in the rcar thermal
  sensor (Niklas Söderlund)

- Cleanup in the qoriq drivers and add a call to
  imx_thermal_unregister_legacy_cooling in the removal function (Anson
  Huang)

- Remove redundant 'maxItems' in tsens and sprd DT bindings (Rob Herring)

- Change the thermal DT bindings by making the cooling-maps optional
  (Yuantian Tang)

- Add Tiger Lake support (Sumeet Pawnikar)

- Use scnprintf() for avoiding potential buffer overflow (Takashi Iwai)

- Make pkg_temp_lock a raw_spinlock_t(Clark Williams)

- Fix incorrect data types by changing them to signed on i.MX SC
(Anson Huang)

- Replace zero-length array with flexible-array member (Gustavo A. R.
Silva)

- Add support for i.MX8MP in the driver and in the DT bindings (Anson
Huang)

- Fix return value of the cpufreq_set_cur_state() function (Willy Wolff)

- Remove abusing and scary WARN_ON in the cpufreq cooling device
  (Daniel Lezcano)

- Fix build warning of incorrect argument type reported by sparse on
  imx8mm (Anson Huang)

- Fix stub for the devfreq cooling device (Martin Blumenstingl)

- Fix cpu idle cooling documentation (Sergey Vidishev)

----------------------------------------------------------------
Amit Kucheria (8):
      drivers: thermal: tsens: De-constify struct tsens_features
      drivers: thermal: tsens: Pass around struct tsens_sensor as a
constant
      drivers: thermal: tsens: use simpler variables
      drivers: thermal: tsens: Release device in success path
      drivers: thermal: tsens: Add critical interrupt support
      drivers: thermal: tsens: Add watchdog support
      drivers: thermal: tsens: kernel-doc fixup
      drivers: thermal: tsens: Remove unnecessary irq flag

Anson Huang (18):
      dt-bindings: fsl: scu: add thermal binding
      thermal: of-thermal: add API for getting sensor ID from DT
      thermal: imx_sc: add i.MX system controller thermal support
      dt-bindings: thermal: imx8mm-thermal: Add binding doc for i.MX8MM
      thermal: imx8mm: Add support for i.MX8MM thermal monitoring unit
      thermal: imx_sc_thermal: Align imx sc thermal msg structs to 4
      thermal: imx_thermal: Use __maybe_unused instead of CONFIG_PM_SLEEP
      thermal: Fix build warning of !defined(CONFIG_THERMAL_OF)
      thermal: Remove COMPILE_TEST for IMX_SC_THERMAL
      thermal: Add COMPILE_TEST support for i.MX8MM
      thermal: imx: Remove unused includes
      thermal: qoriq: Use devm_add_action_or_reset() to handle all
cleanups
      thermal: qoriq: Sort includes alphabetically
      thermal: imx: Calling imx_thermal_unregister_legacy_cooling() in
.remove
      thermal: imx_sc_thermal: Fix incorrect data type
      dt-bindings: thermal: imx8mm-thermal: Add support for i.MX8MP
      thermal: imx8mm: Add i.MX8MP support
      thermal: imx8mm: Fix build warning of incorrect argument type

Baolin Wang (1):
      dt-bindings: thermal: sprd: Add the Spreadtrum thermal documentation

Clark Williams (1):
      thermal/x86_pkg_temp: Make pkg_temp_lock a raw_spinlock_t

Daniel Lezcano (1):
      thermal/drivers/cpufreq_cooling: Remove abusing WARN_ON

Freeman Liu (1):
      thermal: sprd: Add Spreadtrum thermal driver support

Geert Uytterhoeven (2):
      dt-bindings: thermal: rcar-gen3-thermal: Add r8a77961 support
      thermal: rcar_gen3_thermal: Add r8a77961 support

Gustavo A. R. Silva (1):
      thermal: qcom: tsens.h: Replace zero-length array with
flexible-array member

Linus Walleij (2):
      thermal: Rephrase the Kconfig text for thermal
      thermal: ti-soc-thermal: Use GPIO descriptors

Marek Szyprowski (1):
      thermal: exynos: Silence warning during deferred probe

Martin Blumenstingl (1):
      thermal: devfreq_cooling: inline all stubs for
CONFIG_DEVFREQ_THERMAL=n

Niklas Söderlund (6):
      thermal: rcar_gen3_thermal: Remove unneeded curly brackets
      thermal: rcar_gen3_thermal: Generate interrupt when temperature
changes
      thermal: rcar_thermal: Handle probe error gracefully
      thermal: rcar_thermal: Always update thermal zone on interrupt
      thermal: rcar_thermal: Do not store ctemp in rcar_thermal_priv
      thermal: rcar_thermal: Remove lock in
rcar_thermal_get_current_temp()

Rajeshwari (1):
      dt-bindings: thermal: tsens: Add configuration in yaml

Rob Herring (2):
      dt-bindings: thermal: sprd: Remove redundant 'maxItems'
      dt-bindings: thermal: qcom-tsens: Remove redundant 'maxItems'

Sergey Vidishev (1):
      Documentation: cpu-idle-cooling: Fix diagram for 33% duty cycle

Sumeet Pawnikar (1):
      thermal: int340x: processor_thermal: Add Tiger Lake support

Takashi Iwai (1):
      thermal: int340x_thermal: Use scnprintf() for avoiding potential
buffer overflow

Willy Wolff (1):
      thermal/drivers/cpufreq_cooling: Fix return of cpufreq_set_cur_state

Yuantian Tang (2):
      thermal: qoriq: Fix a compiling issue
      dt-bindings: thermal: make cooling-maps property optional

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  16 +
 .../devicetree/bindings/thermal/imx8mm-thermal.txt |  15 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   2 +-
 .../bindings/thermal/rcar-gen3-thermal.txt         |   1 +
 .../devicetree/bindings/thermal/sprd-thermal.yaml  | 107 ++++
 .../devicetree/bindings/thermal/thermal.txt        |   2 +-
 .../driver-api/thermal/cpu-idle-cooling.rst        |   4 +-
 drivers/thermal/Kconfig                            |  42 +-
 drivers/thermal/Makefile                           |   3 +
 drivers/thermal/cpufreq_cooling.c                  |  10 +-
 drivers/thermal/imx8mm_thermal.c                   | 236 +++++++++
 drivers/thermal/imx_sc_thermal.c                   | 148 ++++++
 drivers/thermal/imx_thermal.c                      |  16 +-
 .../intel/int340x_thermal/int3400_thermal.c        |   2 +-
 .../int340x_thermal/processor_thermal_device.c     |   5 +
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |  24 +-
 drivers/thermal/of-thermal.c                       |  62 ++-
 drivers/thermal/qcom/tsens-8960.c                  |   4 +-
 drivers/thermal/qcom/tsens-common.c                | 194 +++++++-
 drivers/thermal/qcom/tsens-v0_1.c                  |   6 +-
 drivers/thermal/qcom/tsens-v1.c                    |   6 +-
 drivers/thermal/qcom/tsens-v2.c                    |  24 +-
 drivers/thermal/qcom/tsens.c                       |  65 ++-
 drivers/thermal/qcom/tsens.h                       | 105 +++-
 drivers/thermal/qoriq_thermal.c                    |  40 +-
 drivers/thermal/rcar_gen3_thermal.c                |  31 +-
 drivers/thermal/rcar_thermal.c                     |  53 +-
 drivers/thermal/samsung/exynos_tmu.c               |   4 +-
 drivers/thermal/sprd_thermal.c                     | 552
+++++++++++++++++++++
 drivers/thermal/st/stm_thermal.c                   |   3 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  44 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |   4 +-
 include/linux/devfreq_cooling.h                    |   2 +-
 include/linux/thermal.h                            |  10 +
 tools/thermal/tmon/tmon.c                          |  26 +-
 35 files changed, 1613 insertions(+), 255 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
 create mode 100644
Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
 create mode 100644 drivers/thermal/imx8mm_thermal.c
 create mode 100644 drivers/thermal/imx_sc_thermal.c
 create mode 100644 drivers/thermal/sprd_thermal.c

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
