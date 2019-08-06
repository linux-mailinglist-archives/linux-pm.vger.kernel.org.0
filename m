Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9631183994
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 21:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfHFTZE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 15:25:04 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44058 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFTZD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 15:25:03 -0400
Received: by mail-oi1-f194.google.com with SMTP id e189so68117263oib.11;
        Tue, 06 Aug 2019 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r400Du+BdhcnVb2kJzBt3FbA/D2Jmeeyq4b8DmzoTuE=;
        b=DqFxHRGxeE89aj7Qk9S9u07itMR2N59xYxVR0F+sAU1LmSLFrJiN5HAHMwrNQ7ct/K
         v/Ol7T2q+hmaYWo/v48u89lPjO0+affKUKx9WKGXAZC24PwmbvsLZoIya7p5fbOLAJ2n
         Vfjh1pYQtqFV9bPQZV3NzTUSWkyGQVqTuN/t+aTTX0L110+DIMg7MCDXx9aODVslSRu7
         RW336Yu4K8W4yAjoSIY798FPBJ/9yYeSQE+nmNFR0dvGLms4arFI7cI6CtDcv084cWgN
         B6PicJp3uO+PPhozN3GtrB4EvahPkew5AqhRv9De+Lo6PYBRI1Ey2lR7vitHuRFnrFXf
         jWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r400Du+BdhcnVb2kJzBt3FbA/D2Jmeeyq4b8DmzoTuE=;
        b=mz9etzojsEATycuabQITbDvYKEhhNW5kSBfYcTJ24DvfLGuolD0AeDrwOx/GFWqOh4
         bpko0uzDh3aaJY1fHehcD8GO4dveSYpbPT/G5tyOiIpESJcjFjbAirPjj+NmZZ8G7KNJ
         rdJnOAJcRtL9x4jibGWuHgOizVv7/jHv4n0T1Bk0o6wzHg79cloBIUAlCyTfcItINyhp
         lPUPIWfEZpad6iZBuKht0G99Jri9LazpEeTEd0uwSapgHCiWkJZSpfzr+9gxyCjC3tcq
         /F/O2lKzczxzP5wo+M2VTz8EoZ7U8TbFlHWO+uWXfaWFSHHzzlPteZfZDsQ3kxZygVKK
         9pOQ==
X-Gm-Message-State: APjAAAUkid7LM/AS9dB0gCzmBrzioAc31nIKM3P6s1RHNcpkOphhZzyH
        ygmVrTbF9G7tmPpBDxFAcgujKoGKdN+UbKerqcKvsbaa
X-Google-Smtp-Source: APXvYqwewYkUVdiv1FBOEZMeibK2YzRko0jtbtspzjUrql75NVp+buCLmwAHPvJS6h0/N8GPAo9FKa2th99cIPmU6t8=
X-Received: by 2002:aca:4306:: with SMTP id q6mr3731470oia.39.1565119502665;
 Tue, 06 Aug 2019 12:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190806130506.8753-1-glaroque@baylibre.com> <20190806130506.8753-5-glaroque@baylibre.com>
In-Reply-To: <20190806130506.8753-5-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 6 Aug 2019 21:24:51 +0200
Message-ID: <CAFBinCBMk=OZH3L0mWL=Wk95MeGey2O+xXD19T1PbYXz2CmuWw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] arm64: dts: meson: sei510: Add minimal thermal zone
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     daniel.lezcano@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 6, 2019 at 3:06 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> Add minimal thermal zone for two temperature sensor
> One is located close to the DDR and the other one is
> located close to the PLLs (between the CPU and GPU)
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
I'm not familiar with the thermal subsystem but this looks sane so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
