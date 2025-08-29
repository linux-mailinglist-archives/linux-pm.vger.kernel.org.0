Return-Path: <linux-pm+bounces-33411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A55B3BB47
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 14:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E058B1C83083
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 12:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178C314B97;
	Fri, 29 Aug 2025 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDrLtLqO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA7265CC0;
	Fri, 29 Aug 2025 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470443; cv=none; b=MEAeTCSJQH7dQXe45j2jbR7xRQCndtNQp1+GQuXJ1QKqbPRmoJW/7+IltG5qsKLCx+HqyR9+3lKTNineDly2UkSDAMHlDNSqxVjCMXB/UbXbRjYztj5Ad+++f0HV6jngN4LWM2OsF/8V5/H7pquhFCs7IAuzmeZwDDx8MZU/uJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470443; c=relaxed/simple;
	bh=t26n87bPfXJxCwL8n21wzenmKbDiAigzoY9uFs/+gQU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=swBvjAawTN2b8/VCzpFL2oIGDQeeU8faox8G+FYPRajvTYkm2G8g4fqzboi6o1L1DEu0D8qbOI1rCSm1HtMJlFlinRKxe4nsyMipJgQ/gptVPuuWePqIGHY1KR3Fw+ZfoHktDiriUEj4LJFMSP8b2wHqCP390Kqv31PI33jwda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDrLtLqO; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f6aef1a7dso373341e87.0;
        Fri, 29 Aug 2025 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756470440; x=1757075240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LwLMCV8O9aymzpnaaoax1GEUnLQN1D5YWoYnYPJ5/EM=;
        b=EDrLtLqO8I91blRy27bWqiTf9/LTHJBWYwkz5eWYVK3ANEPhbWXp7XkUujCOOBYytN
         1SlZ6p4owxEHIMuSxX3sotSJ+NHUuwb9p4UgzqsxjAimqMMEWT3oisinIy9lc+EMk8/Q
         UvjAPi7uONQUW/sYoSm/KbaaXWefg8N9pFAyjQE/y3fcpbsV7qyN+Cu3v18tKQ+zWuLw
         aECNWLTfP0TohNBQs1xdkIOm6jUl4238eOChb1XOYxeHg0MWpE6AUn7B7Ies4MprL4hN
         mZWdiEi7zyLgbtNSziJhRPshfGTxw0xqRtp+hw+W/+E2QOlD6qBfYDlivUVR7KwWSLn+
         aSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470440; x=1757075240;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwLMCV8O9aymzpnaaoax1GEUnLQN1D5YWoYnYPJ5/EM=;
        b=LTqLZ0bJVDE4ieo/9aTK/0K60Hmiu7UnJGmQuMw9ZsQt0OBe6ajekRTP6qj5S8gdD8
         FK3HmFWzewqadHdGdSgqHYPN/Hw11SzntOxvwMEfRJsMje9XF6kSQZX2QyqMJ7kcHTvU
         TQXVvNksukELU/q5YXxxeuavnoxY9iSakPjdLJGcOfKl0Dv0qHWg802z+dbASK48o2X8
         DPTIxXLsay5Z+2zYKuJ/hWmCND0czcFoVrTgf1D7eZYaMS8FcbuFE/YohPY1Jnd2So9u
         vjlOyoEyaX630YhYu+gHqozvjjsAEZB8TY2ojQHXDASDGE92FeD8K8MYo73KGqfPoCSt
         6+1w==
X-Forwarded-Encrypted: i=1; AJvYcCUYjIZm6AEUntYNNAm0OHrsb3bh7i2YITDBY4BB9Z1xnt/xm/aGOVFToM6ntOOzE75kXOOcyjyeFoA=@vger.kernel.org, AJvYcCXofVp50o8Iecsodm1vJ9BTwnwBHDhXUSQ9n8cg6xvEKOFEh5HGcswmji+R0nz5mDxqR0P2RD0tzvncmK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu+q/ypkyvEENlgfg/KZFOUBhAcTe6nRfotywbMrPxHNUxZOrL
	0lx2+X8uHGSTUbKFFL3WxWtB0rGuZxiP0Xc/OE+zdRBTMxrtqqXIGY6h
X-Gm-Gg: ASbGncvbxXwJRYpMiOBQrcKE1yXyQ6RFOEKp+cbTmBeny5TAtF+ff8ewU3lJci6qDWL
	UntksDQLvcEd3KBO5LlpWU7DaJctBEe5euvrXfPrhf5Pktr/vx9Bft5vgwNj7SlAosGyi7iRgl6
	/okyn9Br1PdSf8zCRKlE0h96eiLxqSvmq2J/TnbQZN8obMOXJ4nnDIyLd5GgKN8k5VdeNyO8ls+
	8agkoid13g3W7W2d/MTWe62o8SDlE7fowlTcJWM4NRqNflJGjZ3xxfjHv0vWUG76z2Ce8of2vZf
	lMxoRVpAcoInXHB+ZcePTQbnK23kjEmpFiXMxJkH/L24jcyNkpMmC6m+sFA2geS7y2EeFqFtrHM
	i6PX5TJtd1cUAYcJ6gxdFhsiL1EVLTpVUGfI=
X-Google-Smtp-Source: AGHT+IH4dZIyWHoHC9QisUO1CFwwY5FUKJh415nCwq/HQRY0c5lvTWT4cFBcMXnuOuVU07YOLZZ3Pg==
X-Received: by 2002:a05:6512:b1c:b0:55f:6186:c161 with SMTP id 2adb3069b0e04-55f6186cc25mr1674979e87.49.1756470440135;
        Fri, 29 Aug 2025 05:27:20 -0700 (PDT)
Received: from [172.16.183.204] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f6771b242sm597357e87.51.2025.08.29.05.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:27:19 -0700 (PDT)
Message-ID: <6f56b7b6-8b21-4353-bbca-acf7f9b42ceb@gmail.com>
Date: Fri, 29 Aug 2025 15:27:18 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] power: supply: Add bd718(15/28/78) charger driver
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Andreas Kemnade <andreas@kemnade.info>
Cc: Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20250821-bd71828-charger-v3-0-cc74ac4e0fb9@kemnade.info>
 <20250821-bd71828-charger-v3-2-cc74ac4e0fb9@kemnade.info>
 <CACRpkdbZN3LB=iVwL0YLEoUOiPMSePdOF_NEGWuCncDAjWY4XA@mail.gmail.com>
 <6341e004-880c-4a81-811d-a8b367aab39d@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
In-Reply-To: <6341e004-880c-4a81-811d-a8b367aab39d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/08/2025 09:35, Matti Vaittinen wrote:

>> Some of these look like they should immediately shut down the
>> system, I suppose the battery charger does this autonomously
>> but it should probably also trigger an emergency shutdown
>> of Linux, right?
> 
> Yes. The shutdown for charging, or, in some cases for all power outputs, 
> is automatically handled by the PMIC hardware. (Well, I am not sure 
> about the 'over-current' IRQ, will see if I can find out more about it).

Just to conclude this - I got a confirmation from the ROHM hardware 
engineers that exceeding the set limit and causing the over-current and 
the coulomb counter monitoring interrupts do not change the hardware 
charging state. [CC_MON and OCUR events in the data sheet, if someone 
has that ;) ].

The CC_MON1 will however cause a change in the charging LED state. Eg, 
exceeding this limit will turn off the AMBLED and turn on the GRNLED - 
when the LEDs are controlled by the HW state machine. (I have some very 
faint memory that the LEDs could also be forced ON by software). I 
suppose the reason for this is that the CC_MON1 was designed to be used 
as a "coulomb counter near full capacity" alarm.

Yours,
	-- Matti

